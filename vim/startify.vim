let g:startify_ascii = [
            \ '     ________ ;;     ________',
            \ '    /********\;;;;  /********\',
            \ '    \********/;;;;;;\********/',
            \ '     |******|;;;;;;;;/*****/',
            \ '     |******|;;;;;;/*****/''',
            \ '    ;|******|;;;;/*****/'';',
            \ '  ;;;|******|;;/*****/'';;;;;',
            \ ';;;;;|******|/*****/'';;;;;;;;;',
            \ '  ;;;|***********/'';;;;;;;;;',
            \ '    ;|*********/'';;;;;;;;;',
            \ '     |*******/'';;;;;;;;;',
            \ '     |*****/'';;;;;;;;;',
            \ '     |***/'';;;;;;;;;',
            \ '     |*/''   ;;;;;;',
            \ '              ;;',
            \]
let g:startify_custom_header = map(g:startify_ascii, '"     ".v:val')
let g:startify_padding_left = 5
let g:startify_relative_path = 1
let g:startify_fortune_use_unicode = 1
let g:startify_change_to_vcs_root = 1
" let g:startify_session_autoload = 1
let g:startify_update_oldfiles = 1
let g:startify_use_env = 1
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

hi! link StartifyHeader Directory
hi! link StartifyFile Directory
hi! link StartifyPath LineNr
hi! link StartifySlash StartifyPath
hi! link StartifyBracket StartifyPath
hi! link StartifyNumber Title
