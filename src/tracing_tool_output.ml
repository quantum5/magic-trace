open! Core
open! Async

module Serve = struct
  type t =
    { port : int
    ; perfetto_ui_base_directory : string option
    }

  let param =
    let%map_open.Command port =
      flag "http-port" (optional_with_default 8080 int) ~doc:"PORT http server port"
    and perfetto_ui_base_directory =
      flag
        "perfetto-ui-base-directory"
        (optional string)
        ~doc:"PATH path to Perfetto in filesystem"
    in
    { port; perfetto_ui_base_directory }
  ;;

  let url t =
    let host = Unix.gethostname () in
    Uri.to_string (Uri.make ~scheme:"http" ~host ~port:t.port ())
  ;;

  let request_path req =
    let uri = Cohttp_async.Request.uri req in
    Uri.path uri
  ;;

  let respond_string ~content_type ?flush ?headers ?status s =
    let headers = Cohttp.Header.add_opt headers "Content-Type" content_type in
    Cohttp_async.Server.respond_string ?flush ~headers ?status s
  ;;

  let respond_index t ~filename =
    respond_string
      ~content_type:"text/html"
      ~status:`OK
      [%string
        {|
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>%{filename} - Perfetto UI</title>
    <link rel="shortcut icon" href="/ui/favicon.png">
  </head>
  <body>
    <iframe
      src="/ui/index.html#!/viewer?url=%{url t}/trace/%{filename}"
      style="
        position: fixed;
        border: none;
        top: 0px;
        bottom: 0px;
        right: 0px;
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
      ">
    </iframe>
  </body>
  </html>
    |}]
  ;;

  let serve_trace_file t ~filename ~store_path =
    let static_handler =
      Cohttp_static_handler.directory_handler
        ~directory:(Option.value_exn t.perfetto_ui_base_directory)
        ()
    in
    let handler ~body addr request =
      let path = request_path request in
      (* Uncomment this to debug routing *)
      (* Core.printf "%s\n%!" path; *)
      match path with
      | "" | "/" | "/index.html" -> respond_index t ~filename
      (* Serve the trace under any name under /trace/ so only the HTML has to change *)
      | s when String.is_prefix s ~prefix:"/trace/" ->
        let headers =
          Cohttp.Header.add_opt None "Content-Type" "application/octet-stream"
        in
        Cohttp_async.Server.respond_with_file ~headers store_path
      | _ -> static_handler ~body addr request
    in
    let where_to_listen =
      Tcp.Where_to_listen.bind_to Tcp.Bind_to_address.All_addresses (On_port t.port)
    in
    let open Deferred.Or_error.Let_syntax in
    let%bind server =
      Cohttp_async.Server.create ~on_handler_error:`Raise where_to_listen handler
      |> Deferred.ok
    in
    let stop = Cohttp_async.Server.close_finished server in
    Async_unix.Signal.handle ~stop [ Signal.int ] ~f:(fun (_ : Signal.t) ->
        Cohttp_async.Server.close server |> don't_wait_for);
    Core.eprintf "Open %s to view the %s in Perfetto!\n%!" (url t) filename;
    stop |> Deferred.ok
  ;;

  let serve_file t ~path =
    let filename = Filename.basename path in
    serve_trace_file t ~filename ~store_path:path
  ;;
end

type t =
  { serve_info : Serve.t
  ; serve_always : bool
  ; store_path : string option
  }

let param =
  let%map_open.Command store_path =
    flag
      "output"
      (optional string)
      ~doc:"FILE output file name, serves temporary trace if missing"
  and serve_always =
    flag "serve-always" no_arg ~doc:"serve trace even when output path provided"
  and serve_info = Serve.param in
  { serve_info; serve_always; store_path }
;;

let notify_trace ~store_path =
  Core.eprintf "Visit https://ui.perfetto.dev/ and open %s to view trace.\n%!" store_path;
  Deferred.Or_error.ok_unit
;;

let maybe_serve t ~is_temporary ~filename ~store_path =
  if (is_temporary || t.serve_always)
     && Option.is_some t.serve_info.perfetto_ui_base_directory
  then Serve.serve_trace_file t.serve_info ~filename ~store_path
  else notify_trace ~store_path
;;

let write_and_maybe_serve ?num_temp_strs t ~is_temporary ~filename ~store_path ~f =
  let open Deferred.Or_error.Let_syntax in
  let w = Tracing_zero.Writer.create_for_file ?num_temp_strs ~filename:store_path () in
  let%bind res = f w in
  let%map () = maybe_serve t ~is_temporary ~filename ~store_path in
  res
;;

let with_tempfile ~prefix ~suffix f =
  let filename, fd = Core_unix.mkstemp [%string "%{prefix}.tmp.XXXXXX%{suffix}"] in
  Core_unix.close fd;
  let go () = f filename in
  let finally () = Unix.unlink filename in
  Monitor.protect ~here:[%here] ~name:"with_tempfile" go ~finally
;;

let write_and_view ?num_temp_strs t ~default_name ~f =
  match t.store_path with
  | Some store_path ->
    let filename = Filename.basename store_path in
    write_and_maybe_serve ?num_temp_strs t ~is_temporary:false ~filename ~store_path ~f
  | None ->
    (* FIXME: Use an in-memory trace destination instead of a temp file *)
    with_tempfile ~prefix:"trace" ~suffix:".ftf" (fun store_path ->
        let filename = default_name ^ ".ftf" in
        write_and_maybe_serve ?num_temp_strs t ~is_temporary:true ~filename ~store_path ~f)
;;
