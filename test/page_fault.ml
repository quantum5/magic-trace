open! Core

let%expect_test "A page fault during demo.c" =
  Perf_script.run ~trace_mode:Userspace_and_kernel "page_fault.perf";
  [%expect
    {|
    1439745/1439745 2472089.651284813:   jmp                      7f59488f90f7 call_destructors+0x67 =>     7f5948676e18 _fini+0x0
     instruction trace error type 1 time 2472089.651285037 cpu -1 pid 1439745 tid 1439745 ip 0x7f5948676e18 code 7: Overflow packet
    ->    224ns BEGIN [decode error: Overflow packet]
    ->          END   [decode error: Overflow packet]
    ->      0ns BEGIN _fini [inferred start time]
    ->    224ns END   _fini
    1439745/1439745 2472089.651285037:   tr strt                             0 [unknown] => ffffffffae200ab0 asm_exc_page_fault+0x0
    1439745/1439745 2472089.651285037:   call                 ffffffffae200ab3 asm_exc_page_fault+0x3 => ffffffffae201310 error_entry+0x0
    1439745/1439745 2472089.651285124:   call                 ffffffffae20137a error_entry+0x6a => ffffffffae121a30 sync_regs+0x0
    ->    225ns BEGIN asm_exc_page_fault
    ->    268ns BEGIN error_entry
    1439745/1439745 2472089.651285217:   return               ffffffffae121a51 sync_regs+0x21 => ffffffffae20137f error_entry+0x6f
    ->    311ns BEGIN sync_regs
    1439745/1439745 2472089.651285217:   return               ffffffffae201384 error_entry+0x74 => ffffffffae200ab8 asm_exc_page_fault+0x8
    1439745/1439745 2472089.651285217:   call                 ffffffffae200ac9 asm_exc_page_fault+0x19 => ffffffffae124750 exc_page_fault+0x0
    1439745/1439745 2472089.651285217:   call                 ffffffffae124780 exc_page_fault+0x30 => ffffffffae124c20 irqentry_enter+0x0
    1439745/1439745 2472089.651285219:   call                 ffffffffae124c3b irqentry_enter+0x1b => ffffffffae124c10 irqentry_enter_from_user_mode+0x0
    ->    404ns END   sync_regs
    ->    404ns END   error_entry
    ->    404ns BEGIN exc_page_fault
    ->    405ns BEGIN irqentry_enter
    1439745/1439745 2472089.651285219:   return               ffffffffae124c10 irqentry_enter_from_user_mode+0x0 => ffffffffae124c40 irqentry_enter+0x20
    1439745/1439745 2472089.651285219:   return               ffffffffae124c42 irqentry_enter+0x22 => ffffffffae124785 exc_page_fault+0x35
    1439745/1439745 2472089.651285219:   call                 ffffffffae1247bd exc_page_fault+0x6d => ffffffffad677f70 do_user_addr_fault+0x0
    1439745/1439745 2472089.651285239:   call                 ffffffffad67809c do_user_addr_fault+0x12c => ffffffffad6f5a40 down_read_trylock+0x0
    ->    406ns BEGIN irqentry_enter_from_user_mode
    ->    416ns END   irqentry_enter_from_user_mode
    ->    416ns END   irqentry_enter
    ->    416ns BEGIN do_user_addr_fault
    1439745/1439745 2472089.651285247:   return               ffffffffad6f5a7f down_read_trylock+0x3f => ffffffffad6780a1 do_user_addr_fault+0x131
    ->    426ns BEGIN down_read_trylock
    1439745/1439745 2472089.651285247:   call                 ffffffffad6780b4 do_user_addr_fault+0x144 => ffffffffad885d90 find_vma+0x0
    1439745/1439745 2472089.651285247:   call                 ffffffffad885da1 find_vma+0x11 => ffffffffad871280 vmacache_find+0x0
    1439745/1439745 2472089.651285276:   return               ffffffffad8712f3 vmacache_find+0x73 => ffffffffad885da6 find_vma+0x16
    ->    434ns END   down_read_trylock
    ->    434ns BEGIN find_vma
    ->    448ns BEGIN vmacache_find
    1439745/1439745 2472089.651285290:   call                 ffffffffad885deb find_vma+0x5b => ffffffffad871240 vmacache_update+0x0
    ->    463ns END   vmacache_find
    1439745/1439745 2472089.651285291:   return               ffffffffad871271 vmacache_update+0x31 => ffffffffad885df0 find_vma+0x60
    ->    477ns BEGIN vmacache_update
    1439745/1439745 2472089.651285292:   return               ffffffffad885db1 find_vma+0x21 => ffffffffad6780b9 do_user_addr_fault+0x149
    ->    478ns END   vmacache_update
    1439745/1439745 2472089.651285293:   call                 ffffffffad678127 do_user_addr_fault+0x1b7 => ffffffffad881480 handle_mm_fault+0x0
    ->    479ns END   find_vma
    1439745/1439745 2472089.651285293:   call                 ffffffffad8814bf handle_mm_fault+0x3f => ffffffffad8e5c60 mem_cgroup_from_task+0x0
    1439745/1439745 2472089.651285298:   return               ffffffffad8e5c75 mem_cgroup_from_task+0x15 => ffffffffad8814c4 handle_mm_fault+0x44
    ->    480ns BEGIN handle_mm_fault
    ->    482ns BEGIN mem_cgroup_from_task
    1439745/1439745 2472089.651285298:   call                 ffffffffad8814e7 handle_mm_fault+0x67 => ffffffffad8eaf20 __count_memcg_events+0x0
    1439745/1439745 2472089.651285298:   call                 ffffffffad8eaf47 __count_memcg_events+0x27 => ffffffffad75a340 cgroup_rstat_updated+0x0
    1439745/1439745 2472089.651285307:   return               ffffffffad75a36e cgroup_rstat_updated+0x2e => ffffffffad8eaf4c __count_memcg_events+0x2c
    ->    485ns END   mem_cgroup_from_task
    ->    485ns BEGIN __count_memcg_events
    ->    489ns BEGIN cgroup_rstat_updated
    1439745/1439745 2472089.651285308:   return               ffffffffad8eaf7a __count_memcg_events+0x5a => ffffffffad8814ec handle_mm_fault+0x6c
    ->    494ns END   cgroup_rstat_updated
    1439745/1439745 2472089.651285308:   call                 ffffffffad8816d8 handle_mm_fault+0x258 => ffffffffad878f40 arch_local_irq_enable+0x0
    1439745/1439745 2472089.651285309:   return               ffffffffad878f47 arch_local_irq_enable+0x7 => ffffffffad8816dd handle_mm_fault+0x25d
    ->    495ns END   __count_memcg_events
    ->    495ns BEGIN arch_local_irq_enable
    1439745/1439745 2472089.651285309:   call                 ffffffffad8814f9 handle_mm_fault+0x79 => ffffffffad717230 rcu_read_unlock_strict+0x0
    1439745/1439745 2472089.651285310:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad8814fe handle_mm_fault+0x7e
    ->    496ns END   arch_local_irq_enable
    ->    496ns BEGIN rcu_read_unlock_strict
    1439745/1439745 2472089.651285310:   call                 ffffffffad88154a handle_mm_fault+0xca => ffffffffad87ff50 __handle_mm_fault+0x0
    1439745/1439745 2472089.651285317:   call                 ffffffffad88000d __handle_mm_fault+0xbd => ffffffffad878ff0 pgd_none+0x0
    ->    497ns END   rcu_read_unlock_strict
    ->    497ns BEGIN __handle_mm_fault
    1439745/1439745 2472089.651285318:   return               ffffffffad879000 pgd_none+0x10 => ffffffffad880012 __handle_mm_fault+0xc2
    ->    504ns BEGIN pgd_none
    1439745/1439745 2472089.651285318:   call                 ffffffffad880020 __handle_mm_fault+0xd0 => ffffffffad879320 p4d_offset+0x0
    1439745/1439745 2472089.651285319:   return               ffffffffad879361 p4d_offset+0x41 => ffffffffad880025 __handle_mm_fault+0xd5
    ->    505ns END   pgd_none
    ->    505ns BEGIN p4d_offset
    1439745/1439745 2472089.651285319:   call                 ffffffffad88011f __handle_mm_fault+0x1cf => ffffffffad878f30 pud_val+0x0
    1439745/1439745 2472089.651285320:   return               ffffffffad878f37 pud_val+0x7 => ffffffffad880124 __handle_mm_fault+0x1d4
    ->    506ns END   p4d_offset
    ->    506ns BEGIN pud_val
    1439745/1439745 2472089.651285320:   call                 ffffffffad880132 __handle_mm_fault+0x1e2 => ffffffffad878f30 pud_val+0x0
    1439745/1439745 2472089.651285321:   return               ffffffffad878f37 pud_val+0x7 => ffffffffad880137 __handle_mm_fault+0x1e7
    ->    507ns END   pud_val
    ->    507ns BEGIN pud_val
    1439745/1439745 2472089.651285322:   call                 ffffffffad8801cc __handle_mm_fault+0x27c => ffffffffad878f30 pud_val+0x0
    ->    508ns END   pud_val
    1439745/1439745 2472089.651285322:   return               ffffffffad878f37 pud_val+0x7 => ffffffffad8801d1 __handle_mm_fault+0x281
    1439745/1439745 2472089.651285323:   call                 ffffffffad88021c __handle_mm_fault+0x2cc => ffffffffad878f30 pud_val+0x0
    ->    509ns BEGIN pud_val
    ->    510ns END   pud_val
    1439745/1439745 2472089.651285323:   return               ffffffffad878f37 pud_val+0x7 => ffffffffad880221 __handle_mm_fault+0x2d1
    1439745/1439745 2472089.651285323:   call                 ffffffffad880233 __handle_mm_fault+0x2e3 => ffffffffad878f30 pud_val+0x0
    1439745/1439745 2472089.651285324:   return               ffffffffad878f37 pud_val+0x7 => ffffffffad880238 __handle_mm_fault+0x2e8
    ->    510ns BEGIN pud_val
    ->    510ns END   pud_val
    ->    510ns BEGIN pud_val
    1439745/1439745 2472089.651285324:   call                 ffffffffad8802b8 __handle_mm_fault+0x368 => ffffffffad878f20 pmd_val+0x0
    1439745/1439745 2472089.651285326:   return               ffffffffad878f27 pmd_val+0x7 => ffffffffad8802bd __handle_mm_fault+0x36d
    ->    511ns END   pud_val
    ->    511ns BEGIN pmd_val
    1439745/1439745 2472089.651285326:   call                 ffffffffad8802d7 __handle_mm_fault+0x387 => ffffffffad878f20 pmd_val+0x0
    1439745/1439745 2472089.651285327:   return               ffffffffad878f27 pmd_val+0x7 => ffffffffad8802dc __handle_mm_fault+0x38c
    ->    513ns END   pmd_val
    ->    513ns BEGIN pmd_val
    1439745/1439745 2472089.651285327:   call                 ffffffffad8805a1 __handle_mm_fault+0x651 => ffffffffad878f20 pmd_val+0x0
    1439745/1439745 2472089.651285328:   return               ffffffffad878f27 pmd_val+0x7 => ffffffffad8805a6 __handle_mm_fault+0x656
    ->    514ns END   pmd_val
    ->    514ns BEGIN pmd_val
    1439745/1439745 2472089.651285328:   call                 ffffffffad880790 __handle_mm_fault+0x840 => ffffffffad878f20 pmd_val+0x0
    1439745/1439745 2472089.651285329:   return               ffffffffad878f27 pmd_val+0x7 => ffffffffad880795 __handle_mm_fault+0x845
    ->    515ns END   pmd_val
    ->    515ns BEGIN pmd_val
    1439745/1439745 2472089.651285329:   call                 ffffffffad880807 __handle_mm_fault+0x8b7 => ffffffffad878fb0 pmd_page_vaddr+0x0
    1439745/1439745 2472089.651285329:   call                 ffffffffad878fb4 pmd_page_vaddr+0x4 => ffffffffad878f20 pmd_val+0x0
    1439745/1439745 2472089.651285331:   return               ffffffffad878f27 pmd_val+0x7 => ffffffffad878fb9 pmd_page_vaddr+0x9
    ->    516ns END   pmd_val
    ->    516ns BEGIN pmd_page_vaddr
    ->    517ns BEGIN pmd_val
    1439745/1439745 2472089.651285331:   return               ffffffffad878fed pmd_page_vaddr+0x3d => ffffffffad88080c __handle_mm_fault+0x8bc
    1439745/1439745 2472089.651285339:   call                 ffffffffad880c1e __handle_mm_fault+0xcce => ffffffffad83bac0 filemap_map_pages+0x0
    ->    518ns END   pmd_val
    ->    518ns END   pmd_page_vaddr
    1439745/1439745 2472089.651285339:   call                 ffffffffad83bb47 filemap_map_pages+0x87 => ffffffffadb56bd0 xas_find+0x0
    1439745/1439745 2472089.651285351:   call                 ffffffffadb56d2c xas_find+0x15c => ffffffffadb56920 xas_load+0x0
    ->    526ns BEGIN filemap_map_pages
    ->    532ns BEGIN xas_find
    1439745/1439745 2472089.651285351:   call                 ffffffffadb56920 xas_load+0x0 => ffffffffadb55f90 xas_start+0x0
    1439745/1439745 2472089.651285357:   return               ffffffffadb55fd7 xas_start+0x47 => ffffffffadb56925 xas_load+0x5
    ->    538ns BEGIN xas_load
    ->    541ns BEGIN xas_start
    1439745/1439745 2472089.651285366:   return               ffffffffadb5698d xas_load+0x6d => ffffffffadb56d31 xas_find+0x161
    ->    544ns END   xas_start
    1439745/1439745 2472089.651285366:   return               ffffffffadb56c95 xas_find+0xc5 => ffffffffad83bb4c filemap_map_pages+0x8c
    1439745/1439745 2472089.651285366:   call                 ffffffffad83bb5a filemap_map_pages+0x9a => ffffffffad83a190 next_uptodate_page+0x0
    1439745/1439745 2472089.651285438:   return               ffffffffad83a325 next_uptodate_page+0x195 => ffffffffad83bb5f filemap_map_pages+0x9f
    ->    553ns END   xas_load
    ->    553ns END   xas_find
    ->    553ns BEGIN next_uptodate_page
    1439745/1439745 2472089.651285439:   call                 ffffffffad83be42 filemap_map_pages+0x382 => ffffffffae1335d0 _raw_spin_lock+0x0
    ->    625ns END   next_uptodate_page
    1439745/1439745 2472089.651285446:   return               ffffffffae1335e2 _raw_spin_lock+0x12 => ffffffffad83be47 filemap_map_pages+0x387
    ->    626ns BEGIN _raw_spin_lock
    1439745/1439745 2472089.651285446:   call                 ffffffffad83be9d filemap_map_pages+0x3dd => ffffffffad8b49c0 PageHuge+0x0
    1439745/1439745 2472089.651285448:   return               ffffffffad8b49ef PageHuge+0x2f => ffffffffad83bea2 filemap_map_pages+0x3e2
    ->    633ns END   _raw_spin_lock
    ->    633ns BEGIN PageHuge
    1439745/1439745 2472089.651285448:   call                 ffffffffad83bf1b filemap_map_pages+0x45b => ffffffffad87d430 do_set_pte+0x0
    1439745/1439745 2472089.651285448:   call                 ffffffffad87d465 do_set_pte+0x35 => ffffffffad8796a0 pfn_pte+0x0
    1439745/1439745 2472089.651285450:   return               ffffffffad8796d5 pfn_pte+0x35 => ffffffffad87d46a do_set_pte+0x3a
    ->    635ns END   PageHuge
    ->    635ns BEGIN do_set_pte
    ->    636ns BEGIN pfn_pte
    1439745/1439745 2472089.651285451:   call                 ffffffffad87d4b9 do_set_pte+0x89 => ffffffffad879450 add_mm_counter_fast+0x0
    ->    637ns END   pfn_pte
    1439745/1439745 2472089.651285451:   return               ffffffffad879471 add_mm_counter_fast+0x21 => ffffffffad87d4be do_set_pte+0x8e
    1439745/1439745 2472089.651285451:   call                 ffffffffad87d4c3 do_set_pte+0x93 => ffffffffad892300 page_add_file_rmap+0x0
    1439745/1439745 2472089.651285451:   call                 ffffffffad89230e page_add_file_rmap+0xe => ffffffffad8e6ae0 lock_page_memcg+0x0
    1439745/1439745 2472089.651285454:   return               ffffffffad8e6b56 lock_page_memcg+0x76 => ffffffffad892313 page_add_file_rmap+0x13
    ->    638ns BEGIN add_mm_counter_fast
    ->    639ns END   add_mm_counter_fast
    ->    639ns BEGIN page_add_file_rmap
    ->    640ns BEGIN lock_page_memcg
    1439745/1439745 2472089.651285454:   call                 ffffffffad89238b page_add_file_rmap+0x8b => ffffffffad8eae80 __mod_lruvec_page_state+0x0
    1439745/1439745 2472089.651285461:   call                 ffffffffad8eaedb __mod_lruvec_page_state+0x5b => ffffffffad8eae40 __mod_lruvec_state+0x0
    ->    641ns END   lock_page_memcg
    ->    641ns BEGIN __mod_lruvec_page_state
    1439745/1439745 2472089.651285461:   call                 ffffffffad8eae5d __mod_lruvec_state+0x1d => ffffffffad860e50 __mod_node_page_state+0x0
    1439745/1439745 2472089.651285462:   return               ffffffffad860e9c __mod_node_page_state+0x4c => ffffffffad8eae62 __mod_lruvec_state+0x22
    ->    648ns BEGIN __mod_lruvec_state
    ->    648ns BEGIN __mod_node_page_state
    1439745/1439745 2472089.651285462:   jmp                  ffffffffad8eae72 __mod_lruvec_state+0x32 => ffffffffad8ea010 __mod_memcg_lruvec_state+0x0
    1439745/1439745 2472089.651285462:   call                 ffffffffad8ea04c __mod_memcg_lruvec_state+0x3c => ffffffffad75a340 cgroup_rstat_updated+0x0
    1439745/1439745 2472089.651285465:   return               ffffffffad75a36e cgroup_rstat_updated+0x2e => ffffffffad8ea051 __mod_memcg_lruvec_state+0x41
    ->    649ns END   __mod_node_page_state
    ->    649ns END   __mod_lruvec_state
    ->    649ns BEGIN __mod_memcg_lruvec_state
    ->    650ns BEGIN cgroup_rstat_updated
    1439745/1439745 2472089.651285466:   return               ffffffffad8ea081 __mod_memcg_lruvec_state+0x71 => ffffffffad8eaee0 __mod_lruvec_page_state+0x60
    ->    652ns END   cgroup_rstat_updated
    1439745/1439745 2472089.651285466:   jmp                  ffffffffad8eaee5 __mod_lruvec_page_state+0x65 => ffffffffad717230 rcu_read_unlock_strict+0x0
    1439745/1439745 2472089.651285466:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad892390 page_add_file_rmap+0x90
    1439745/1439745 2472089.651285466:   jmp                  ffffffffad892396 page_add_file_rmap+0x96 => ffffffffad8e6270 unlock_page_memcg+0x0
    1439745/1439745 2472089.651285467:   jmp                  ffffffffad8e62ad unlock_page_memcg+0x3d => ffffffffad717230 rcu_read_unlock_strict+0x0
    ->    653ns END   __mod_memcg_lruvec_state
    ->    653ns END   __mod_lruvec_page_state
    ->    653ns BEGIN rcu_read_unlock_strict
    ->    653ns END   rcu_read_unlock_strict
    ->    653ns END   page_add_file_rmap
    ->    653ns BEGIN unlock_page_memcg
    1439745/1439745 2472089.651285467:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad87d4c8 do_set_pte+0x98
    1439745/1439745 2472089.651285467:   call                 ffffffffad87d4d0 do_set_pte+0xa0 => ffffffffad670640 native_set_pte+0x0
    1439745/1439745 2472089.651285468:   return               ffffffffad670643 native_set_pte+0x3 => ffffffffad87d4d5 do_set_pte+0xa5
    ->    654ns END   unlock_page_memcg
    ->    654ns BEGIN rcu_read_unlock_strict
    ->    654ns END   rcu_read_unlock_strict
    ->    654ns BEGIN native_set_pte
    1439745/1439745 2472089.651285468:   return               ffffffffad87d4e1 do_set_pte+0xb1 => ffffffffad83bf20 filemap_map_pages+0x460
    1439745/1439745 2472089.651285468:   call                 ffffffffad83bf23 filemap_map_pages+0x463 => ffffffffad839530 unlock_page+0x0
    1439745/1439745 2472089.651285473:   return               ffffffffad839549 unlock_page+0x19 => ffffffffad83bf28 filemap_map_pages+0x468
    ->    655ns END   native_set_pte
    ->    655ns END   do_set_pte
    ->    655ns BEGIN unlock_page
    1439745/1439745 2472089.651285474:   call                 ffffffffad83be7f filemap_map_pages+0x3bf => ffffffffad83a190 next_uptodate_page+0x0
    ->    660ns END   unlock_page
    1439745/1439745 2472089.651285525:   return               ffffffffad83a325 next_uptodate_page+0x195 => ffffffffad83be84 filemap_map_pages+0x3c4
    ->    661ns BEGIN next_uptodate_page
    1439745/1439745 2472089.651285525:   call                 ffffffffad83be9d filemap_map_pages+0x3dd => ffffffffad8b49c0 PageHuge+0x0
    1439745/1439745 2472089.651285526:   return               ffffffffad8b49ef PageHuge+0x2f => ffffffffad83bea2 filemap_map_pages+0x3e2
    ->    712ns END   next_uptodate_page
    ->    712ns BEGIN PageHuge
    1439745/1439745 2472089.651285526:   call                 ffffffffad83bf1b filemap_map_pages+0x45b => ffffffffad87d430 do_set_pte+0x0
    1439745/1439745 2472089.651285526:   call                 ffffffffad87d465 do_set_pte+0x35 => ffffffffad8796a0 pfn_pte+0x0
    1439745/1439745 2472089.651285529:   return               ffffffffad8796d5 pfn_pte+0x35 => ffffffffad87d46a do_set_pte+0x3a
    ->    713ns END   PageHuge
    ->    713ns BEGIN do_set_pte
    ->    714ns BEGIN pfn_pte
    1439745/1439745 2472089.651285529:   call                 ffffffffad87d4b9 do_set_pte+0x89 => ffffffffad879450 add_mm_counter_fast+0x0
    1439745/1439745 2472089.651285530:   return               ffffffffad879471 add_mm_counter_fast+0x21 => ffffffffad87d4be do_set_pte+0x8e
    ->    716ns END   pfn_pte
    ->    716ns BEGIN add_mm_counter_fast
    1439745/1439745 2472089.651285530:   call                 ffffffffad87d4c3 do_set_pte+0x93 => ffffffffad892300 page_add_file_rmap+0x0
    1439745/1439745 2472089.651285530:   call                 ffffffffad89230e page_add_file_rmap+0xe => ffffffffad8e6ae0 lock_page_memcg+0x0
    1439745/1439745 2472089.651285533:   return               ffffffffad8e6b56 lock_page_memcg+0x76 => ffffffffad892313 page_add_file_rmap+0x13
    ->    717ns END   add_mm_counter_fast
    ->    717ns BEGIN page_add_file_rmap
    ->    718ns BEGIN lock_page_memcg
    1439745/1439745 2472089.651285533:   call                 ffffffffad89238b page_add_file_rmap+0x8b => ffffffffad8eae80 __mod_lruvec_page_state+0x0
    1439745/1439745 2472089.651285539:   call                 ffffffffad8eaedb __mod_lruvec_page_state+0x5b => ffffffffad8eae40 __mod_lruvec_state+0x0
    ->    720ns END   lock_page_memcg
    ->    720ns BEGIN __mod_lruvec_page_state
    1439745/1439745 2472089.651285539:   call                 ffffffffad8eae5d __mod_lruvec_state+0x1d => ffffffffad860e50 __mod_node_page_state+0x0
    1439745/1439745 2472089.651285540:   return               ffffffffad860e9c __mod_node_page_state+0x4c => ffffffffad8eae62 __mod_lruvec_state+0x22
    ->    726ns BEGIN __mod_lruvec_state
    ->    726ns BEGIN __mod_node_page_state
    1439745/1439745 2472089.651285540:   jmp                  ffffffffad8eae72 __mod_lruvec_state+0x32 => ffffffffad8ea010 __mod_memcg_lruvec_state+0x0
    1439745/1439745 2472089.651285540:   call                 ffffffffad8ea04c __mod_memcg_lruvec_state+0x3c => ffffffffad75a340 cgroup_rstat_updated+0x0
    1439745/1439745 2472089.651285542:   return               ffffffffad75a36e cgroup_rstat_updated+0x2e => ffffffffad8ea051 __mod_memcg_lruvec_state+0x41
    ->    727ns END   __mod_node_page_state
    ->    727ns END   __mod_lruvec_state
    ->    727ns BEGIN __mod_memcg_lruvec_state
    ->    728ns BEGIN cgroup_rstat_updated
    1439745/1439745 2472089.651285547:   return               ffffffffad8ea081 __mod_memcg_lruvec_state+0x71 => ffffffffad8eaee0 __mod_lruvec_page_state+0x60
    ->    729ns END   cgroup_rstat_updated
    1439745/1439745 2472089.651285547:   jmp                  ffffffffad8eaee5 __mod_lruvec_page_state+0x65 => ffffffffad717230 rcu_read_unlock_strict+0x0
    1439745/1439745 2472089.651285548:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad892390 page_add_file_rmap+0x90
    ->    734ns END   __mod_memcg_lruvec_state
    ->    734ns END   __mod_lruvec_page_state
    ->    734ns BEGIN rcu_read_unlock_strict
    1439745/1439745 2472089.651285548:   jmp                  ffffffffad892396 page_add_file_rmap+0x96 => ffffffffad8e6270 unlock_page_memcg+0x0
    1439745/1439745 2472089.651285549:   jmp                  ffffffffad8e62ad unlock_page_memcg+0x3d => ffffffffad717230 rcu_read_unlock_strict+0x0
    ->    735ns END   rcu_read_unlock_strict
    ->    735ns END   page_add_file_rmap
    ->    735ns BEGIN unlock_page_memcg
    1439745/1439745 2472089.651285549:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad87d4c8 do_set_pte+0x98
    1439745/1439745 2472089.651285549:   call                 ffffffffad87d4d0 do_set_pte+0xa0 => ffffffffad670640 native_set_pte+0x0
    1439745/1439745 2472089.651285550:   return               ffffffffad670643 native_set_pte+0x3 => ffffffffad87d4d5 do_set_pte+0xa5
    ->    736ns END   unlock_page_memcg
    ->    736ns BEGIN rcu_read_unlock_strict
    ->    736ns END   rcu_read_unlock_strict
    ->    736ns BEGIN native_set_pte
    1439745/1439745 2472089.651285551:   return               ffffffffad87d4e1 do_set_pte+0xb1 => ffffffffad83bf20 filemap_map_pages+0x460
    ->    737ns END   native_set_pte
    1439745/1439745 2472089.651285551:   call                 ffffffffad83bf23 filemap_map_pages+0x463 => ffffffffad839530 unlock_page+0x0
    1439745/1439745 2472089.651285558:   return               ffffffffad839549 unlock_page+0x19 => ffffffffad83bf28 filemap_map_pages+0x468
    ->    738ns END   do_set_pte
    ->    738ns BEGIN unlock_page
    1439745/1439745 2472089.651285559:   call                 ffffffffad83be7f filemap_map_pages+0x3bf => ffffffffad83a190 next_uptodate_page+0x0
    ->    745ns END   unlock_page
    1439745/1439745 2472089.651285606:   return               ffffffffad83a325 next_uptodate_page+0x195 => ffffffffad83be84 filemap_map_pages+0x3c4
    ->    746ns BEGIN next_uptodate_page
    1439745/1439745 2472089.651285606:   call                 ffffffffad83be9d filemap_map_pages+0x3dd => ffffffffad8b49c0 PageHuge+0x0
    1439745/1439745 2472089.651285607:   return               ffffffffad8b49ef PageHuge+0x2f => ffffffffad83bea2 filemap_map_pages+0x3e2
    ->    793ns END   next_uptodate_page
    ->    793ns BEGIN PageHuge
    1439745/1439745 2472089.651285607:   call                 ffffffffad83bf1b filemap_map_pages+0x45b => ffffffffad87d430 do_set_pte+0x0
    1439745/1439745 2472089.651285607:   call                 ffffffffad87d465 do_set_pte+0x35 => ffffffffad8796a0 pfn_pte+0x0
    1439745/1439745 2472089.651285610:   return               ffffffffad8796d5 pfn_pte+0x35 => ffffffffad87d46a do_set_pte+0x3a
    ->    794ns END   PageHuge
    ->    794ns BEGIN do_set_pte
    ->    795ns BEGIN pfn_pte
    1439745/1439745 2472089.651285610:   call                 ffffffffad87d4b9 do_set_pte+0x89 => ffffffffad879450 add_mm_counter_fast+0x0
    1439745/1439745 2472089.651285611:   return               ffffffffad879471 add_mm_counter_fast+0x21 => ffffffffad87d4be do_set_pte+0x8e
    ->    797ns END   pfn_pte
    ->    797ns BEGIN add_mm_counter_fast
    1439745/1439745 2472089.651285611:   call                 ffffffffad87d4c3 do_set_pte+0x93 => ffffffffad892300 page_add_file_rmap+0x0
    1439745/1439745 2472089.651285611:   call                 ffffffffad89230e page_add_file_rmap+0xe => ffffffffad8e6ae0 lock_page_memcg+0x0
    1439745/1439745 2472089.651285613:   return               ffffffffad8e6b56 lock_page_memcg+0x76 => ffffffffad892313 page_add_file_rmap+0x13
    ->    798ns END   add_mm_counter_fast
    ->    798ns BEGIN page_add_file_rmap
    ->    799ns BEGIN lock_page_memcg
    1439745/1439745 2472089.651285613:   call                 ffffffffad89238b page_add_file_rmap+0x8b => ffffffffad8eae80 __mod_lruvec_page_state+0x0
    1439745/1439745 2472089.651285619:   call                 ffffffffad8eaedb __mod_lruvec_page_state+0x5b => ffffffffad8eae40 __mod_lruvec_state+0x0
    ->    800ns END   lock_page_memcg
    ->    800ns BEGIN __mod_lruvec_page_state
    1439745/1439745 2472089.651285619:   call                 ffffffffad8eae5d __mod_lruvec_state+0x1d => ffffffffad860e50 __mod_node_page_state+0x0
    1439745/1439745 2472089.651285621:   return               ffffffffad860e9c __mod_node_page_state+0x4c => ffffffffad8eae62 __mod_lruvec_state+0x22
    ->    806ns BEGIN __mod_lruvec_state
    ->    807ns BEGIN __mod_node_page_state
    1439745/1439745 2472089.651285621:   jmp                  ffffffffad8eae72 __mod_lruvec_state+0x32 => ffffffffad8ea010 __mod_memcg_lruvec_state+0x0
    1439745/1439745 2472089.651285621:   call                 ffffffffad8ea04c __mod_memcg_lruvec_state+0x3c => ffffffffad75a340 cgroup_rstat_updated+0x0
    1439745/1439745 2472089.651285623:   return               ffffffffad75a36e cgroup_rstat_updated+0x2e => ffffffffad8ea051 __mod_memcg_lruvec_state+0x41
    ->    808ns END   __mod_node_page_state
    ->    808ns END   __mod_lruvec_state
    ->    808ns BEGIN __mod_memcg_lruvec_state
    ->    809ns BEGIN cgroup_rstat_updated
    1439745/1439745 2472089.651285624:   return               ffffffffad8ea081 __mod_memcg_lruvec_state+0x71 => ffffffffad8eaee0 __mod_lruvec_page_state+0x60
    ->    810ns END   cgroup_rstat_updated
    1439745/1439745 2472089.651285624:   jmp                  ffffffffad8eaee5 __mod_lruvec_page_state+0x65 => ffffffffad717230 rcu_read_unlock_strict+0x0
    1439745/1439745 2472089.651285624:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad892390 page_add_file_rmap+0x90
    1439745/1439745 2472089.651285624:   jmp                  ffffffffad892396 page_add_file_rmap+0x96 => ffffffffad8e6270 unlock_page_memcg+0x0
    1439745/1439745 2472089.651285625:   jmp                  ffffffffad8e62ad unlock_page_memcg+0x3d => ffffffffad717230 rcu_read_unlock_strict+0x0
    ->    811ns END   __mod_memcg_lruvec_state
    ->    811ns END   __mod_lruvec_page_state
    ->    811ns BEGIN rcu_read_unlock_strict
    ->    811ns END   rcu_read_unlock_strict
    ->    811ns END   page_add_file_rmap
    ->    811ns BEGIN unlock_page_memcg
    1439745/1439745 2472089.651285626:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad87d4c8 do_set_pte+0x98
    ->    812ns END   unlock_page_memcg
    ->    812ns BEGIN rcu_read_unlock_strict
    1439745/1439745 2472089.651285626:   call                 ffffffffad87d4d0 do_set_pte+0xa0 => ffffffffad670640 native_set_pte+0x0
    1439745/1439745 2472089.651285626:   return               ffffffffad670643 native_set_pte+0x3 => ffffffffad87d4d5 do_set_pte+0xa5
    1439745/1439745 2472089.651285626:   return               ffffffffad87d4e1 do_set_pte+0xb1 => ffffffffad83bf20 filemap_map_pages+0x460
    1439745/1439745 2472089.651285626:   call                 ffffffffad83bf23 filemap_map_pages+0x463 => ffffffffad839530 unlock_page+0x0
    1439745/1439745 2472089.651285631:   return               ffffffffad839549 unlock_page+0x19 => ffffffffad83bf28 filemap_map_pages+0x468
    ->    813ns END   rcu_read_unlock_strict
    ->    813ns BEGIN native_set_pte
    ->    815ns END   native_set_pte
    ->    815ns END   do_set_pte
    ->    815ns BEGIN unlock_page
    1439745/1439745 2472089.651285632:   call                 ffffffffad83be7f filemap_map_pages+0x3bf => ffffffffad83a190 next_uptodate_page+0x0
    ->    818ns END   unlock_page
    1439745/1439745 2472089.651285685:   return               ffffffffad83a325 next_uptodate_page+0x195 => ffffffffad83be84 filemap_map_pages+0x3c4
    ->    819ns BEGIN next_uptodate_page
    1439745/1439745 2472089.651285685:   call                 ffffffffad83be9d filemap_map_pages+0x3dd => ffffffffad8b49c0 PageHuge+0x0
    1439745/1439745 2472089.651285686:   return               ffffffffad8b49ef PageHuge+0x2f => ffffffffad83bea2 filemap_map_pages+0x3e2
    ->    872ns END   next_uptodate_page
    ->    872ns BEGIN PageHuge
    1439745/1439745 2472089.651285686:   call                 ffffffffad83bf1b filemap_map_pages+0x45b => ffffffffad87d430 do_set_pte+0x0
    1439745/1439745 2472089.651285686:   call                 ffffffffad87d465 do_set_pte+0x35 => ffffffffad8796a0 pfn_pte+0x0
    1439745/1439745 2472089.651285688:   return               ffffffffad8796d5 pfn_pte+0x35 => ffffffffad87d46a do_set_pte+0x3a
    ->    873ns END   PageHuge
    ->    873ns BEGIN do_set_pte
    ->    874ns BEGIN pfn_pte
    1439745/1439745 2472089.651285689:   call                 ffffffffad87d4b9 do_set_pte+0x89 => ffffffffad879450 add_mm_counter_fast+0x0
    ->    875ns END   pfn_pte
    1439745/1439745 2472089.651285690:   return               ffffffffad879471 add_mm_counter_fast+0x21 => ffffffffad87d4be do_set_pte+0x8e
    ->    876ns BEGIN add_mm_counter_fast
    1439745/1439745 2472089.651285690:   call                 ffffffffad87d4c3 do_set_pte+0x93 => ffffffffad892300 page_add_file_rmap+0x0
    1439745/1439745 2472089.651285690:   call                 ffffffffad89230e page_add_file_rmap+0xe => ffffffffad8e6ae0 lock_page_memcg+0x0
    1439745/1439745 2472089.651285692:   return               ffffffffad8e6b56 lock_page_memcg+0x76 => ffffffffad892313 page_add_file_rmap+0x13
    ->    877ns END   add_mm_counter_fast
    ->    877ns BEGIN page_add_file_rmap
    ->    878ns BEGIN lock_page_memcg
    1439745/1439745 2472089.651285692:   call                 ffffffffad89238b page_add_file_rmap+0x8b => ffffffffad8eae80 __mod_lruvec_page_state+0x0
    1439745/1439745 2472089.651285699:   call                 ffffffffad8eaedb __mod_lruvec_page_state+0x5b => ffffffffad8eae40 __mod_lruvec_state+0x0
    ->    879ns END   lock_page_memcg
    ->    879ns BEGIN __mod_lruvec_page_state
    1439745/1439745 2472089.651285699:   call                 ffffffffad8eae5d __mod_lruvec_state+0x1d => ffffffffad860e50 __mod_node_page_state+0x0
    1439745/1439745 2472089.651285700:   return               ffffffffad860e9c __mod_node_page_state+0x4c => ffffffffad8eae62 __mod_lruvec_state+0x22
    ->    886ns BEGIN __mod_lruvec_state
    ->    886ns BEGIN __mod_node_page_state
    1439745/1439745 2472089.651285700:   jmp                  ffffffffad8eae72 __mod_lruvec_state+0x32 => ffffffffad8ea010 __mod_memcg_lruvec_state+0x0
    1439745/1439745 2472089.651285700:   call                 ffffffffad8ea04c __mod_memcg_lruvec_state+0x3c => ffffffffad75a340 cgroup_rstat_updated+0x0
    1439745/1439745 2472089.651285702:   return               ffffffffad75a36e cgroup_rstat_updated+0x2e => ffffffffad8ea051 __mod_memcg_lruvec_state+0x41
    ->    887ns END   __mod_node_page_state
    ->    887ns END   __mod_lruvec_state
    ->    887ns BEGIN __mod_memcg_lruvec_state
    ->    888ns BEGIN cgroup_rstat_updated
    1439745/1439745 2472089.651285703:   return               ffffffffad8ea081 __mod_memcg_lruvec_state+0x71 => ffffffffad8eaee0 __mod_lruvec_page_state+0x60
    ->    889ns END   cgroup_rstat_updated
    1439745/1439745 2472089.651285703:   jmp                  ffffffffad8eaee5 __mod_lruvec_page_state+0x65 => ffffffffad717230 rcu_read_unlock_strict+0x0
    1439745/1439745 2472089.651285703:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad892390 page_add_file_rmap+0x90
    1439745/1439745 2472089.651285703:   jmp                  ffffffffad892396 page_add_file_rmap+0x96 => ffffffffad8e6270 unlock_page_memcg+0x0
    1439745/1439745 2472089.651285704:   jmp                  ffffffffad8e62ad unlock_page_memcg+0x3d => ffffffffad717230 rcu_read_unlock_strict+0x0
    ->    890ns END   __mod_memcg_lruvec_state
    ->    890ns END   __mod_lruvec_page_state
    ->    890ns BEGIN rcu_read_unlock_strict
    ->    890ns END   rcu_read_unlock_strict
    ->    890ns END   page_add_file_rmap
    ->    890ns BEGIN unlock_page_memcg
    1439745/1439745 2472089.651285705:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad87d4c8 do_set_pte+0x98
    ->    891ns END   unlock_page_memcg
    ->    891ns BEGIN rcu_read_unlock_strict
    1439745/1439745 2472089.651285705:   call                 ffffffffad87d4d0 do_set_pte+0xa0 => ffffffffad670640 native_set_pte+0x0
    1439745/1439745 2472089.651285705:   return               ffffffffad670643 native_set_pte+0x3 => ffffffffad87d4d5 do_set_pte+0xa5
    1439745/1439745 2472089.651285705:   return               ffffffffad87d4e1 do_set_pte+0xb1 => ffffffffad83bf20 filemap_map_pages+0x460
    1439745/1439745 2472089.651285705:   call                 ffffffffad83bf23 filemap_map_pages+0x463 => ffffffffad839530 unlock_page+0x0
    1439745/1439745 2472089.651285710:   return               ffffffffad839549 unlock_page+0x19 => ffffffffad83bf28 filemap_map_pages+0x468
    ->    892ns END   rcu_read_unlock_strict
    ->    892ns BEGIN native_set_pte
    ->    894ns END   native_set_pte
    ->    894ns END   do_set_pte
    ->    894ns BEGIN unlock_page
    1439745/1439745 2472089.651285711:   call                 ffffffffad83be7f filemap_map_pages+0x3bf => ffffffffad83a190 next_uptodate_page+0x0
    ->    897ns END   unlock_page
    1439745/1439745 2472089.651285763:   return               ffffffffad83a325 next_uptodate_page+0x195 => ffffffffad83be84 filemap_map_pages+0x3c4
    ->    898ns BEGIN next_uptodate_page
    1439745/1439745 2472089.651285763:   call                 ffffffffad83be9d filemap_map_pages+0x3dd => ffffffffad8b49c0 PageHuge+0x0
    1439745/1439745 2472089.651285765:   return               ffffffffad8b49ef PageHuge+0x2f => ffffffffad83bea2 filemap_map_pages+0x3e2
    ->    950ns END   next_uptodate_page
    ->    950ns BEGIN PageHuge
    1439745/1439745 2472089.651285765:   call                 ffffffffad83bf1b filemap_map_pages+0x45b => ffffffffad87d430 do_set_pte+0x0
    1439745/1439745 2472089.651285765:   call                 ffffffffad87d465 do_set_pte+0x35 => ffffffffad8796a0 pfn_pte+0x0
    1439745/1439745 2472089.651285767:   return               ffffffffad8796d5 pfn_pte+0x35 => ffffffffad87d46a do_set_pte+0x3a
    ->    952ns END   PageHuge
    ->    952ns BEGIN do_set_pte
    ->    953ns BEGIN pfn_pte
    1439745/1439745 2472089.651285767:   call                 ffffffffad87d4b9 do_set_pte+0x89 => ffffffffad879450 add_mm_counter_fast+0x0
    1439745/1439745 2472089.651285768:   return               ffffffffad879471 add_mm_counter_fast+0x21 => ffffffffad87d4be do_set_pte+0x8e
    ->    954ns END   pfn_pte
    ->    954ns BEGIN add_mm_counter_fast
    1439745/1439745 2472089.651285768:   call                 ffffffffad87d4c3 do_set_pte+0x93 => ffffffffad892300 page_add_file_rmap+0x0
    1439745/1439745 2472089.651285768:   call                 ffffffffad89230e page_add_file_rmap+0xe => ffffffffad8e6ae0 lock_page_memcg+0x0
    1439745/1439745 2472089.651285770:   return               ffffffffad8e6b56 lock_page_memcg+0x76 => ffffffffad892313 page_add_file_rmap+0x13
    ->    955ns END   add_mm_counter_fast
    ->    955ns BEGIN page_add_file_rmap
    ->    956ns BEGIN lock_page_memcg
    1439745/1439745 2472089.651285771:   call                 ffffffffad89238b page_add_file_rmap+0x8b => ffffffffad8eae80 __mod_lruvec_page_state+0x0
    ->    957ns END   lock_page_memcg
    1439745/1439745 2472089.651285777:   call                 ffffffffad8eaedb __mod_lruvec_page_state+0x5b => ffffffffad8eae40 __mod_lruvec_state+0x0
    ->    958ns BEGIN __mod_lruvec_page_state
    1439745/1439745 2472089.651285777:   call                 ffffffffad8eae5d __mod_lruvec_state+0x1d => ffffffffad860e50 __mod_node_page_state+0x0
    1439745/1439745 2472089.651285884:   return               ffffffffad860e9c __mod_node_page_state+0x4c => ffffffffad8eae62 __mod_lruvec_state+0x22
    ->    964ns BEGIN __mod_lruvec_state
    ->  1.017us BEGIN __mod_node_page_state
    1439745/1439745 2472089.651285884:   jmp                  ffffffffad8eae72 __mod_lruvec_state+0x32 => ffffffffad8ea010 __mod_memcg_lruvec_state+0x0
    1439745/1439745 2472089.651285884:   call                 ffffffffad8ea04c __mod_memcg_lruvec_state+0x3c => ffffffffad75a340 cgroup_rstat_updated+0x0
    1439745/1439745 2472089.651285890:   return               ffffffffad75a36e cgroup_rstat_updated+0x2e => ffffffffad8ea051 __mod_memcg_lruvec_state+0x41
    ->  1.071us END   __mod_node_page_state
    ->  1.071us END   __mod_lruvec_state
    ->  1.071us BEGIN __mod_memcg_lruvec_state
    ->  1.074us BEGIN cgroup_rstat_updated
    1439745/1439745 2472089.651285891:   return               ffffffffad8ea081 __mod_memcg_lruvec_state+0x71 => ffffffffad8eaee0 __mod_lruvec_page_state+0x60
    ->  1.077us END   cgroup_rstat_updated
    1439745/1439745 2472089.651285891:   jmp                  ffffffffad8eaee5 __mod_lruvec_page_state+0x65 => ffffffffad717230 rcu_read_unlock_strict+0x0
    1439745/1439745 2472089.651285891:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad892390 page_add_file_rmap+0x90
    1439745/1439745 2472089.651285891:   jmp                  ffffffffad892396 page_add_file_rmap+0x96 => ffffffffad8e6270 unlock_page_memcg+0x0
    1439745/1439745 2472089.651285893:   jmp                  ffffffffad8e62ad unlock_page_memcg+0x3d => ffffffffad717230 rcu_read_unlock_strict+0x0
    ->  1.078us END   __mod_memcg_lruvec_state
    ->  1.078us END   __mod_lruvec_page_state
    ->  1.078us BEGIN rcu_read_unlock_strict
    ->  1.079us END   rcu_read_unlock_strict
    ->  1.079us END   page_add_file_rmap
    ->  1.079us BEGIN unlock_page_memcg
    1439745/1439745 2472089.651285895:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad87d4c8 do_set_pte+0x98
    ->   1.08us END   unlock_page_memcg
    ->   1.08us BEGIN rcu_read_unlock_strict
    1439745/1439745 2472089.651285895:   call                 ffffffffad87d4d0 do_set_pte+0xa0 => ffffffffad670640 native_set_pte+0x0
    1439745/1439745 2472089.651285895:   return               ffffffffad670643 native_set_pte+0x3 => ffffffffad87d4d5 do_set_pte+0xa5
    1439745/1439745 2472089.651285896:   return               ffffffffad87d4e1 do_set_pte+0xb1 => ffffffffad83bf20 filemap_map_pages+0x460
    ->  1.082us END   rcu_read_unlock_strict
    ->  1.082us BEGIN native_set_pte
    ->  1.083us END   native_set_pte
    1439745/1439745 2472089.651285896:   call                 ffffffffad83bf23 filemap_map_pages+0x463 => ffffffffad839530 unlock_page+0x0
    1439745/1439745 2472089.651285917:   return               ffffffffad839549 unlock_page+0x19 => ffffffffad83bf28 filemap_map_pages+0x468
    ->  1.083us END   do_set_pte
    ->  1.083us BEGIN unlock_page
    1439745/1439745 2472089.651285918:   call                 ffffffffad83be7f filemap_map_pages+0x3bf => ffffffffad83a190 next_uptodate_page+0x0
    ->  1.104us END   unlock_page
    1439745/1439745 2472089.651285942:   return               ffffffffad83a325 next_uptodate_page+0x195 => ffffffffad83be84 filemap_map_pages+0x3c4
    ->  1.105us BEGIN next_uptodate_page
    1439745/1439745 2472089.651285942:   call                 ffffffffad83be9d filemap_map_pages+0x3dd => ffffffffad8b49c0 PageHuge+0x0
    1439745/1439745 2472089.651285943:   return               ffffffffad8b49ef PageHuge+0x2f => ffffffffad83bea2 filemap_map_pages+0x3e2
    ->  1.129us END   next_uptodate_page
    ->  1.129us BEGIN PageHuge
    1439745/1439745 2472089.651285943:   call                 ffffffffad83bf1b filemap_map_pages+0x45b => ffffffffad87d430 do_set_pte+0x0
    1439745/1439745 2472089.651285943:   call                 ffffffffad87d465 do_set_pte+0x35 => ffffffffad8796a0 pfn_pte+0x0
    1439745/1439745 2472089.651285945:   return               ffffffffad8796d5 pfn_pte+0x35 => ffffffffad87d46a do_set_pte+0x3a
    ->   1.13us END   PageHuge
    ->   1.13us BEGIN do_set_pte
    ->  1.131us BEGIN pfn_pte
    1439745/1439745 2472089.651285945:   call                 ffffffffad87d4b9 do_set_pte+0x89 => ffffffffad879450 add_mm_counter_fast+0x0
    1439745/1439745 2472089.651285946:   return               ffffffffad879471 add_mm_counter_fast+0x21 => ffffffffad87d4be do_set_pte+0x8e
    ->  1.132us END   pfn_pte
    ->  1.132us BEGIN add_mm_counter_fast
    1439745/1439745 2472089.651285946:   call                 ffffffffad87d4c3 do_set_pte+0x93 => ffffffffad892300 page_add_file_rmap+0x0
    1439745/1439745 2472089.651285946:   call                 ffffffffad89230e page_add_file_rmap+0xe => ffffffffad8e6ae0 lock_page_memcg+0x0
    1439745/1439745 2472089.651285948:   return               ffffffffad8e6b56 lock_page_memcg+0x76 => ffffffffad892313 page_add_file_rmap+0x13
    ->  1.133us END   add_mm_counter_fast
    ->  1.133us BEGIN page_add_file_rmap
    ->  1.134us BEGIN lock_page_memcg
    1439745/1439745 2472089.651285949:   call                 ffffffffad89238b page_add_file_rmap+0x8b => ffffffffad8eae80 __mod_lruvec_page_state+0x0
    ->  1.135us END   lock_page_memcg
    1439745/1439745 2472089.651285955:   call                 ffffffffad8eaedb __mod_lruvec_page_state+0x5b => ffffffffad8eae40 __mod_lruvec_state+0x0
    ->  1.136us BEGIN __mod_lruvec_page_state
    1439745/1439745 2472089.651285955:   call                 ffffffffad8eae5d __mod_lruvec_state+0x1d => ffffffffad860e50 __mod_node_page_state+0x0
    1439745/1439745 2472089.651285957:   return               ffffffffad860e9c __mod_node_page_state+0x4c => ffffffffad8eae62 __mod_lruvec_state+0x22
    ->  1.142us BEGIN __mod_lruvec_state
    ->  1.143us BEGIN __mod_node_page_state
    1439745/1439745 2472089.651285957:   jmp                  ffffffffad8eae72 __mod_lruvec_state+0x32 => ffffffffad8ea010 __mod_memcg_lruvec_state+0x0
    1439745/1439745 2472089.651285957:   call                 ffffffffad8ea04c __mod_memcg_lruvec_state+0x3c => ffffffffad75a340 cgroup_rstat_updated+0x0
    1439745/1439745 2472089.651285958:   return               ffffffffad75a36e cgroup_rstat_updated+0x2e => ffffffffad8ea051 __mod_memcg_lruvec_state+0x41
    ->  1.144us END   __mod_node_page_state
    ->  1.144us END   __mod_lruvec_state
    ->  1.144us BEGIN __mod_memcg_lruvec_state
    ->  1.144us BEGIN cgroup_rstat_updated
    1439745/1439745 2472089.651285959:   return               ffffffffad8ea081 __mod_memcg_lruvec_state+0x71 => ffffffffad8eaee0 __mod_lruvec_page_state+0x60
    ->  1.145us END   cgroup_rstat_updated
    1439745/1439745 2472089.651285959:   jmp                  ffffffffad8eaee5 __mod_lruvec_page_state+0x65 => ffffffffad717230 rcu_read_unlock_strict+0x0
    1439745/1439745 2472089.651285960:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad892390 page_add_file_rmap+0x90
    ->  1.146us END   __mod_memcg_lruvec_state
    ->  1.146us END   __mod_lruvec_page_state
    ->  1.146us BEGIN rcu_read_unlock_strict
    1439745/1439745 2472089.651285960:   jmp                  ffffffffad892396 page_add_file_rmap+0x96 => ffffffffad8e6270 unlock_page_memcg+0x0
    1439745/1439745 2472089.651285961:   jmp                  ffffffffad8e62ad unlock_page_memcg+0x3d => ffffffffad717230 rcu_read_unlock_strict+0x0
    ->  1.147us END   rcu_read_unlock_strict
    ->  1.147us END   page_add_file_rmap
    ->  1.147us BEGIN unlock_page_memcg
    1439745/1439745 2472089.651285961:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad87d4c8 do_set_pte+0x98
    1439745/1439745 2472089.651285961:   call                 ffffffffad87d4d0 do_set_pte+0xa0 => ffffffffad670640 native_set_pte+0x0
    1439745/1439745 2472089.651285961:   return               ffffffffad670643 native_set_pte+0x3 => ffffffffad87d4d5 do_set_pte+0xa5
    1439745/1439745 2472089.651285962:   return               ffffffffad87d4e1 do_set_pte+0xb1 => ffffffffad83bf20 filemap_map_pages+0x460
    ->  1.148us END   unlock_page_memcg
    ->  1.148us BEGIN rcu_read_unlock_strict
    ->  1.148us END   rcu_read_unlock_strict
    ->  1.148us BEGIN native_set_pte
    ->  1.149us END   native_set_pte
    1439745/1439745 2472089.651285962:   call                 ffffffffad83bf23 filemap_map_pages+0x463 => ffffffffad839530 unlock_page+0x0
    1439745/1439745 2472089.651285967:   return               ffffffffad839549 unlock_page+0x19 => ffffffffad83bf28 filemap_map_pages+0x468
    ->  1.149us END   do_set_pte
    ->  1.149us BEGIN unlock_page
    1439745/1439745 2472089.651285968:   call                 ffffffffad83be7f filemap_map_pages+0x3bf => ffffffffad83a190 next_uptodate_page+0x0
    ->  1.154us END   unlock_page
    1439745/1439745 2472089.651286019:   return               ffffffffad83a325 next_uptodate_page+0x195 => ffffffffad83be84 filemap_map_pages+0x3c4
    ->  1.155us BEGIN next_uptodate_page
    1439745/1439745 2472089.651286019:   call                 ffffffffad83be9d filemap_map_pages+0x3dd => ffffffffad8b49c0 PageHuge+0x0
    1439745/1439745 2472089.651286020:   return               ffffffffad8b49ef PageHuge+0x2f => ffffffffad83bea2 filemap_map_pages+0x3e2
    ->  1.206us END   next_uptodate_page
    ->  1.206us BEGIN PageHuge
    1439745/1439745 2472089.651286020:   call                 ffffffffad83bf1b filemap_map_pages+0x45b => ffffffffad87d430 do_set_pte+0x0
    1439745/1439745 2472089.651286020:   call                 ffffffffad87d465 do_set_pte+0x35 => ffffffffad8796a0 pfn_pte+0x0
    1439745/1439745 2472089.651286023:   return               ffffffffad8796d5 pfn_pte+0x35 => ffffffffad87d46a do_set_pte+0x3a
    ->  1.207us END   PageHuge
    ->  1.207us BEGIN do_set_pte
    ->  1.208us BEGIN pfn_pte
    1439745/1439745 2472089.651286023:   call                 ffffffffad87d4b9 do_set_pte+0x89 => ffffffffad879450 add_mm_counter_fast+0x0
    1439745/1439745 2472089.651286025:   return               ffffffffad879471 add_mm_counter_fast+0x21 => ffffffffad87d4be do_set_pte+0x8e
    ->   1.21us END   pfn_pte
    ->   1.21us BEGIN add_mm_counter_fast
    1439745/1439745 2472089.651286025:   call                 ffffffffad87d4c3 do_set_pte+0x93 => ffffffffad892300 page_add_file_rmap+0x0
    1439745/1439745 2472089.651286025:   call                 ffffffffad89230e page_add_file_rmap+0xe => ffffffffad8e6ae0 lock_page_memcg+0x0
    1439745/1439745 2472089.651286027:   return               ffffffffad8e6b56 lock_page_memcg+0x76 => ffffffffad892313 page_add_file_rmap+0x13
    ->  1.212us END   add_mm_counter_fast
    ->  1.212us BEGIN page_add_file_rmap
    ->  1.213us BEGIN lock_page_memcg
    1439745/1439745 2472089.651286027:   call                 ffffffffad89238b page_add_file_rmap+0x8b => ffffffffad8eae80 __mod_lruvec_page_state+0x0
    1439745/1439745 2472089.651286034:   call                 ffffffffad8eaedb __mod_lruvec_page_state+0x5b => ffffffffad8eae40 __mod_lruvec_state+0x0
    ->  1.214us END   lock_page_memcg
    ->  1.214us BEGIN __mod_lruvec_page_state
    1439745/1439745 2472089.651286034:   call                 ffffffffad8eae5d __mod_lruvec_state+0x1d => ffffffffad860e50 __mod_node_page_state+0x0
    1439745/1439745 2472089.651286035:   return               ffffffffad860e9c __mod_node_page_state+0x4c => ffffffffad8eae62 __mod_lruvec_state+0x22
    ->  1.221us BEGIN __mod_lruvec_state
    ->  1.221us BEGIN __mod_node_page_state
    1439745/1439745 2472089.651286035:   jmp                  ffffffffad8eae72 __mod_lruvec_state+0x32 => ffffffffad8ea010 __mod_memcg_lruvec_state+0x0
    1439745/1439745 2472089.651286035:   call                 ffffffffad8ea04c __mod_memcg_lruvec_state+0x3c => ffffffffad75a340 cgroup_rstat_updated+0x0
    1439745/1439745 2472089.651286037:   return               ffffffffad75a36e cgroup_rstat_updated+0x2e => ffffffffad8ea051 __mod_memcg_lruvec_state+0x41
    ->  1.222us END   __mod_node_page_state
    ->  1.222us END   __mod_lruvec_state
    ->  1.222us BEGIN __mod_memcg_lruvec_state
    ->  1.223us BEGIN cgroup_rstat_updated
    1439745/1439745 2472089.651286038:   return               ffffffffad8ea081 __mod_memcg_lruvec_state+0x71 => ffffffffad8eaee0 __mod_lruvec_page_state+0x60
    ->  1.224us END   cgroup_rstat_updated
    1439745/1439745 2472089.651286038:   jmp                  ffffffffad8eaee5 __mod_lruvec_page_state+0x65 => ffffffffad717230 rcu_read_unlock_strict+0x0
    1439745/1439745 2472089.651286038:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad892390 page_add_file_rmap+0x90
    1439745/1439745 2472089.651286038:   jmp                  ffffffffad892396 page_add_file_rmap+0x96 => ffffffffad8e6270 unlock_page_memcg+0x0
    1439745/1439745 2472089.651286039:   jmp                  ffffffffad8e62ad unlock_page_memcg+0x3d => ffffffffad717230 rcu_read_unlock_strict+0x0
    ->  1.225us END   __mod_memcg_lruvec_state
    ->  1.225us END   __mod_lruvec_page_state
    ->  1.225us BEGIN rcu_read_unlock_strict
    ->  1.225us END   rcu_read_unlock_strict
    ->  1.225us END   page_add_file_rmap
    ->  1.225us BEGIN unlock_page_memcg
    1439745/1439745 2472089.651286040:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad87d4c8 do_set_pte+0x98
    ->  1.226us END   unlock_page_memcg
    ->  1.226us BEGIN rcu_read_unlock_strict
    1439745/1439745 2472089.651286040:   call                 ffffffffad87d4d0 do_set_pte+0xa0 => ffffffffad670640 native_set_pte+0x0
    1439745/1439745 2472089.651286040:   return               ffffffffad670643 native_set_pte+0x3 => ffffffffad87d4d5 do_set_pte+0xa5
    1439745/1439745 2472089.651286040:   return               ffffffffad87d4e1 do_set_pte+0xb1 => ffffffffad83bf20 filemap_map_pages+0x460
    1439745/1439745 2472089.651286040:   call                 ffffffffad83bf23 filemap_map_pages+0x463 => ffffffffad839530 unlock_page+0x0
    1439745/1439745 2472089.651286046:   return               ffffffffad839549 unlock_page+0x19 => ffffffffad83bf28 filemap_map_pages+0x468
    ->  1.227us END   rcu_read_unlock_strict
    ->  1.227us BEGIN native_set_pte
    ->   1.23us END   native_set_pte
    ->   1.23us END   do_set_pte
    ->   1.23us BEGIN unlock_page
    1439745/1439745 2472089.651286046:   call                 ffffffffad83be6c filemap_map_pages+0x3ac => ffffffffadb56bd0 xas_find+0x0
    1439745/1439745 2472089.651286049:   return               ffffffffadb56cc9 xas_find+0xf9 => ffffffffad83be71 filemap_map_pages+0x3b1
    ->  1.233us END   unlock_page
    ->  1.233us BEGIN xas_find
    1439745/1439745 2472089.651286049:   call                 ffffffffad83be7f filemap_map_pages+0x3bf => ffffffffad83a190 next_uptodate_page+0x0
    1439745/1439745 2472089.651286050:   return               ffffffffad83a325 next_uptodate_page+0x195 => ffffffffad83be84 filemap_map_pages+0x3c4
    ->  1.236us END   xas_find
    ->  1.236us BEGIN next_uptodate_page
    1439745/1439745 2472089.651286051:   call                 ffffffffad83bbf3 filemap_map_pages+0x133 => ffffffffad717230 rcu_read_unlock_strict+0x0
    ->  1.237us END   next_uptodate_page
    1439745/1439745 2472089.651286052:   return               ffffffffad717235 rcu_read_unlock_strict+0x5 => ffffffffad83bbf8 filemap_map_pages+0x138
    ->  1.238us BEGIN rcu_read_unlock_strict
    1439745/1439745 2472089.651286053:   return               ffffffffad83bc2d filemap_map_pages+0x16d => ffffffffad880c20 __handle_mm_fault+0xcd0
    ->  1.239us END   rcu_read_unlock_strict
    1439745/1439745 2472089.651286053:   return               ffffffffad880368 __handle_mm_fault+0x418 => ffffffffad88154f handle_mm_fault+0xcf
    1439745/1439745 2472089.651286055:   return               ffffffffad881599 handle_mm_fault+0x119 => ffffffffad67812c do_user_addr_fault+0x1bc
    ->   1.24us END   filemap_map_pages
    ->   1.24us END   __handle_mm_fault
    1439745/1439745 2472089.651286055:   call                 ffffffffad678144 do_user_addr_fault+0x1d4 => ffffffffad6f5fd0 up_read+0x0
    1439745/1439745 2472089.651286060:   return               ffffffffad6f5fef up_read+0x1f => ffffffffad678149 do_user_addr_fault+0x1d9
    ->  1.242us END   handle_mm_fault
    ->  1.242us BEGIN up_read
    1439745/1439745 2472089.651286061:   return               ffffffffad677fdb do_user_addr_fault+0x6b => ffffffffae1247c2 exc_page_fault+0x72
    ->  1.247us END   up_read
    1439745/1439745 2472089.651286061:   jmp                  ffffffffae1247d6 exc_page_fault+0x86 => ffffffffae124c60 irqentry_exit+0x0
    1439745/1439745 2472089.651286062:   jmp                  ffffffffae124c82 irqentry_exit+0x22 => ffffffffae124c50 irqentry_exit_to_user_mode+0x0
    ->  1.248us END   do_user_addr_fault
    ->  1.248us END   exc_page_fault
    ->  1.248us BEGIN irqentry_exit
    1439745/1439745 2472089.651286062:   call                 ffffffffae124c50 irqentry_exit_to_user_mode+0x0 => ffffffffad721f00 exit_to_user_mode_prepare+0x0
    1439745/1439745 2472089.651286071:   return               ffffffffad721f58 exit_to_user_mode_prepare+0x58 => ffffffffae124c55 irqentry_exit_to_user_mode+0x5
    ->  1.249us END   irqentry_exit
    ->  1.249us BEGIN irqentry_exit_to_user_mode
    ->  1.253us BEGIN exit_to_user_mode_prepare
    1439745/1439745 2472089.651286071:   return               ffffffffae124c5e irqentry_exit_to_user_mode+0xe => ffffffffae200ace asm_exc_page_fault+0x1e
    1439745/1439745 2472089.651286071:   jmp                  ffffffffae200ace asm_exc_page_fault+0x1e => ffffffffae2013f0 error_return+0x0
    1439745/1439745 2472089.651286072:   jmp                  ffffffffae2013fe error_return+0xe => ffffffffae200ff0 __irqentry_text_end+0x0
    ->  1.258us END   exit_to_user_mode_prepare
    ->  1.258us END   irqentry_exit_to_user_mode
    ->  1.258us END   asm_exc_page_fault
    ->  1.258us BEGIN error_return
    1439745/1439745 2472089.651286072:   jmp                  ffffffffae201073 __irqentry_text_end+0x83 => ffffffffae2010a0 native_iret+0x0
    1439745/1439745 2472089.651286160:   iret                 ffffffffae2010a7 native_irq_return_iret+0x0 =>     7f5948676e18 _fini+0x0
    ->  1.259us END   error_return
    ->  1.259us BEGIN __irqentry_text_end
    ->  1.303us END   __irqentry_text_end
    ->  1.303us BEGIN native_iret
    1439745/1439745 2472089.651286186:   return                   7f5948676e24 _fini+0xc =>     7f5948832e75 _dl_catch_exception+0xe5
    ->  1.347us END   native_iret
    END
    ->    224ns BEGIN _dl_catch_exception [inferred start time]
    ->    224ns BEGIN _fini [inferred start time]
    ->  1.373us END   _fini
    ->  1.373us END   _dl_catch_exception |}]
;;
