fu! tutorial#trainingWheelsProtocol(...)
    if a:0 == 0
        cal s:trainingWheelsPopupsActivate()
    elseif a:1 == 'deactive'
        cal s:trainingWheelsPopupsDeActivate()
    elseif a:1 == 'quick'
        cal s:trainingWheelsPopupsActivateQuick()
    endif
endf

fu! tutorial#modes(A, L, P) abort
    retu ['deactive', 'quick']
endf

let s:training_popup_cursor1_winid = 0
let s:training_popup_cursor2_winid = 0
let s:training_popup_window1_winid = 0
let s:training_popup_window2_winid = 0
let s:training_popup_mode1_winid = 0
let s:training_popup_mode2_winid = 0
let s:training_popup_search_winid = 0
let s:training_popup_opeobj_winid = 0
let s:training_popup_tips_winid = 0
let s:training_popup_tips_win_flg = 0
let s:training_popup_tips_win_tid = 0

fu! s:trainingWheelsPopupsActivate()
    cal s:trainingWheelsPracticeFileCreate()
    cal s:trainingWheelsPopupsAllClose()
    let s:training_info_idx = 0
    hi TrainingNotification ctermfg=green guifg=green
    hi Traininginfo ctermfg=cyan guifg=cyan cterm=BOLD gui=BOLD
    cal popup_notification([
        \'             = Infomation =          ',
        \' Training Wheels Protocol Activated.',
        \'  ↓Create and Open practice file. ',
        \'   ~/practice.md. ',
        \'  ',
        \' To DeActivate',
        \' :TrainingWheelsProtocol deactive'
        \],#{border:[],
        \zindex:999,
        \highlight:'TrainingNotification',
        \time:3000})
    cal timer_start(1000, function('s:trainingInfo'))
    cal timer_start(6000, function('s:trainingInfo'))
    cal timer_start(6500, function('s:trainingPopupCursor1'))
    cal timer_start(6500, function('s:trainingPopupCursor1SampleMv'))
    cal timer_start(10000, function('s:trainingInfo'))
    cal timer_start(10500, function('s:trainingPopupCursor2'))
    cal timer_start(10500, function('s:trainingPopupCursor2SampleMv'))
    cal timer_start(15000, function('s:trainingInfo'))
    cal timer_start(15500, function('s:trainingPopupWindow1'))
    cal timer_start(15500, function('s:trainingPopupWindow1SampleMv'))
    cal timer_start(20000, function('s:trainingInfo'))
    cal timer_start(20500, function('s:trainingPopupWindow2'))
    cal timer_start(20500, function('s:trainingPopupWindow2SampleMv'))
    cal timer_start(26000, function('s:trainingInfo'))
    cal timer_start(29000, function('s:trainingInfo'))
    cal timer_start(29500, function('s:trainingPopupMode1'))
    cal timer_start(32000, function('s:trainingInfo'))
    cal timer_start(35000, function('s:trainingInfo'))
    cal timer_start(35500, function('s:trainingPopupMode2'))
    cal timer_start(35500, function('s:trainingPopupMode2SampleMv'))
    cal timer_start(38000, function('s:trainingInfo'))
    cal timer_start(38500, function('s:trainingPopupSearch'))
    cal timer_start(38500, function('s:trainingPopupSearchSampleMv'))
    cal timer_start(42000, function('s:trainingInfo'))
    cal timer_start(45000, function('s:trainingInfo'))
    cal timer_start(45500, function('s:trainingPopupOpeObj'))
    cal timer_start(45500, function('s:trainingPopupOpeObjSampleMv'))
    cal timer_start(49000, function('s:trainingInfo'))
    let s:training_popup_tips_win_tid = timer_start(49500, function('s:trainingPopupTips'))
    cal timer_start(49500, function('s:trainingPopupTipsCursor'))
    cal timer_start(52000, function('s:trainingInfo'))
endf

fu! s:trainingWheelsPopupsActivateQuick()
    if s:training_info_idx != 0 && s:training_info_idx != len(s:training_info_txt)
        echo 'Enjoy tutorial till the end.'
        retu
    endif

    cal popup_notification([' Traning Wheels Activated. ','To DeActivate :Tutorial deactive'],#{border:[]})
    let s:training_info_idx = len(s:training_info_txt)
    cal s:trainingWheelsPopupsAllClose()
    cal s:trainingPopupCursor1(0)
    cal s:trainingPopupCursor2(0)
    cal s:trainingPopupWindow1(0)
    cal s:trainingPopupWindow2(0)
    cal s:trainingPopupMode1(0)
    cal s:trainingPopupMode2(0)
    cal s:trainingPopupSearch(0)
    cal s:trainingPopupOpeObj(0)
    let s:training_popup_tips_win_tid = timer_start(100, function('s:trainingPopupTips'))
    cal s:trainingPopupTipsCursor(0)
endf

fu! s:trainingWheelsPopupsDeActivate()
    if s:training_info_idx == 0
        echo 'No Training Wheels.'
        retu
    elseif s:training_info_idx != len(s:training_info_txt)
        echo 'Enjoy tutorial till the end.'
        retu
    endif

    aug training_tips_popup
        au!
    aug END
    cal popup_notification([' Traning Wheels DeActivated. ',' to open popups without tutorial :Tutorial quick'],#{border:[]})
    cal s:trainingWheelsPopupsAllClose()
endf

fu! s:trainingWheelsPopupsAllClose()
    let s:training_popup_tips_win_flg = 0
    cal timer_stop(s:training_popup_tips_win_tid)
    cal popup_close(s:training_popup_cursor1_winid)
    cal popup_close(s:training_popup_cursor2_winid)
    cal popup_close(s:training_popup_window1_winid)
    cal popup_close(s:training_popup_window2_winid)
    cal popup_close(s:training_popup_mode1_winid)
    cal popup_close(s:training_popup_mode2_winid)
    cal popup_close(s:training_popup_search_winid)
    cal popup_close(s:training_popup_opeobj_winid)
    cal popup_close(s:training_popup_tips_winid)
endf

" [[txtarr, time], ...]
let s:training_info_idx = 0
let s:training_info_txt = [
      \[[' ======================================== ',
      \'     WELCOME TO TUTORIAL ANIMATION.   ',
      \' ======================================== ',
      \' Please watch this on full screen.  ',
      \'',
      \'    While this training mode is active, ',
      \'    always show you popups',
      \'    that learn how to operate vim. ',
      \'',
      \' Enjoy 1 min tutorial, then practice vim!'], 5000],
      \[[' This is the cursor motion at NORMAL MODE. '], 4000],
      \[[' And how to JUMP cursor in ROW is ... '], 5000],
      \[[' Then, window SCROLL motions are there. '], 5000],
      \[[' Also you can JUMP cursor ON WINDOW. '], 6000],
      \[[' When you edit file, maybe write words. ',
      \' Then you can use INSERT MODE. '], 3000],
      \[[' How to get INSERT MODE is here. '], 3000],
      \[[' Do you want to save file? '], 3000],
      \[[' COMMAND MODE is convenience. '], 3000],
      \[[' And how to SEARCH word is here. '], 3000],
      \[[' You can improve motion moreover. '], 3000],
      \[[' Use "Operator" & "TextObject". '], 4000],
      \[[' Undo Redo Repeat is ... '], 3000],
      \[[" At the end, tutorial is over. ",
      \' These popup remain until DeActivate TrainingWheelsProtocol ',
      \' Enjoy your vim life ! '], 5000],
      \]
fu! s:trainingInfo(timer)
    let inf = s:training_info_txt[s:training_info_idx]
    cal popup_notification(inf[0],#{border:[],
                \zindex:999,
                \highlight:'Traininginfo',
                \pos:'center',
                \time:inf[1]})
    let s:training_info_idx += 1
endf

" cursor move
fu! s:trainingPopupCursor1(timer)
    let s:training_popup_cursor1_winid = popup_create([
        \'     ↑ k ',
        \' h ←   → l ',
        \'   j ↓  ',
        \],#{title: ' cursor move ',
        \border: [], zindex: 1,
        \line: 3,
        \col: &columns - 46
        \})
    cal matchaddpos("Identifier", [[1,10],[2,2],[2,14],[3,4]], 16, -1, #{window: s:training_popup_cursor1_winid})
endf

fu! s:trainingPopupCursor1SampleMv(timer)
    execute("norm gg")
    cal cursor(26, 6)
    cal timer_start(600, function('s:trainingPopupCursor1SampleMv1'))
    cal timer_start(1200, function('s:trainingPopupCursor1SampleMv2'))
    cal timer_start(1800, function('s:trainingPopupCursor1SampleMv3'))
    cal timer_start(2400, function('s:trainingPopupCursor1SampleMv4'))
endf
fu! s:trainingPopupCursor1SampleMv1(timer)
    execute("norm h")
    echo("h   cursor move")
endf
fu! s:trainingPopupCursor1SampleMv2(timer)
    execute("norm j")
    echo("j   cursor move")
endf
fu! s:trainingPopupCursor1SampleMv3(timer)
    execute("norm l")
    echo("l   cursor move")
endf
fu! s:trainingPopupCursor1SampleMv4(timer)
    execute("norm k")
    echo("k   cursor move")
endf

" cursor jump
fu! s:trainingPopupCursor2(timer)
    let s:training_popup_cursor2_winid = popup_create([
        \' -[jump_in_row]------------ ',
        \'  0    b←  →w   w  e     $',
        \'  This is | the test text. ',
        \'        cursor     ',
        \' -[jump_to_char f / t]-----',
        \'               repeat ',
        \'    Th Fi    fe  ;    tx ',
        \'    ↓  ↓      ↓  ↓    ↓  ',
        \'  This is | the test text. ',
        \'        cursor     ',
        \],#{title: ' cursor jump ',
        \border: [], zindex: 1,
        \line: 3,
        \col: &columns - 31
        \})
    cal matchaddpos("Identifier", [[2,3],[2,8],[2,17],[2,21],[2,24],[2,30]], 16, -1, #{window: s:training_popup_cursor2_winid})
    cal matchaddpos("Identifier", [[5,17],[5,21]], 16, -1, #{window: s:training_popup_cursor2_winid})
    cal matchaddpos("Identifier", [[7,5,2],[7,8,2],[7,14,2],[7,18],[7,23,2]], 16, -1, #{window: s:training_popup_cursor2_winid})
    cal matchaddpos("Comment", [[3,3,7],[3,13,14],[9,3,7],[9,13,14]], 16, -1, #{window: s:training_popup_cursor2_winid})
endf

fu! s:trainingPopupCursor2SampleMv(timer)
    execute("norm gg")
    cal cursor(15, 12)
    cal timer_start(200, function('s:trainingPopupCursor2SampleMv1'))
    cal timer_start(900, function('s:trainingPopupCursor2SampleMv1'))
    cal timer_start(1600, function('s:trainingPopupCursor2SampleMv2'))
    cal timer_start(2300, function('s:trainingPopupCursor2SampleMv3'))
    cal timer_start(3000, function('s:trainingPopupCursor2SampleMv4'))
    cal timer_start(3700, function('s:trainingPopupCursor2SampleMv5'))
endf
fu! s:trainingPopupCursor2SampleMv1(timer)
    execute("norm w")
    echo("w   next word first char")
endf
fu! s:trainingPopupCursor2SampleMv2(timer)
    execute("norm e")
    echo("e   next wort last char")
endf
fu! s:trainingPopupCursor2SampleMv3(timer)
    cal cursor(15, 12)
    echo("and ...")
endf
fu! s:trainingPopupCursor2SampleMv4(timer)
    execute("norm fe")
    echo("fe   next first e")
endf
fu! s:trainingPopupCursor2SampleMv5(timer)
    execute("norm tx")
    echo("tx   next first x, before 1")
endf


" move window
fu! s:trainingPopupWindow1(timer)
    let s:training_popup_window1_winid = popup_create([
        \'   page top/bottom         scroll ',
        \'  -----------------   ----------------- ',
        \' | gg              | | C-f  forward    | ',
        \' |                 | |                 | ',
        \' |                 | | C-u  up         | ',
        \' |                 | | ↑               | ',
        \' | 15G (line no)   | |                 | ',
        \' |                 | | ↓               | ',
        \' |                 | | C-d  down       | ',
        \' |                 | |                 | ',
        \' | G               | | C-b  back       | ',
        \'  -----------------   ----------------- ',
        \],#{title: ' move window ',
        \border: [], zindex: 1,
        \line: 16,
        \col: &columns - 44
        \})
    cal matchaddpos("Identifier", [[3,4,2],[3,24,3]], 16, -1, #{window: s:training_popup_window1_winid})
    cal matchaddpos("Identifier", [[5,24,3]], 16, -1, #{window: s:training_popup_window1_winid})
    cal matchaddpos("Identifier", [[7,4,3]], 16, -1, #{window: s:training_popup_window1_winid})
    cal matchaddpos("Identifier", [[9,24,3]], 16, -1, #{window: s:training_popup_window1_winid})
    cal matchaddpos("Identifier", [[11,4,1],[11,24,3]], 16, -1, #{window: s:training_popup_window1_winid})
endf

fu! s:trainingPopupWindow1SampleMv(timer)
    execute("norm gg")
    cal timer_start(200, function('s:trainingPopupWindow1SampleMv1'))
    cal timer_start(1200, function('s:trainingPopupWindow1SampleMv2'))
    cal timer_start(2200, function('s:trainingPopupWindow1SampleMv3'))
    cal timer_start(3200, function('s:trainingPopupWindow1SampleMv4'))
endf
fu! s:trainingPopupWindow1SampleMv1(timer)
    execute "norm \<C-d>"
    echo("C-d   pade down")
endf
fu! s:trainingPopupWindow1SampleMv2(timer)
    execute("norm gg")
    echo("gg   page top")
endf
fu! s:trainingPopupWindow1SampleMv3(timer)
    execute("norm G")
    echo("G   page last")
endf
fu! s:trainingPopupWindow1SampleMv4(timer)
    execute("norm 15G")
    echo("15G   line 15")
endf

" cursor jump in window
fu! s:trainingPopupWindow2(timer)
    let s:training_popup_window2_winid = popup_create([
        \'   High Middle Low         paragraph         scroll stay cursor ',
        \'  -----------------    ------------------    -------------------- ',
        \' |                 |  |                  |  |                    | ',
        \' | H               |  | {                |  | == current line == | ',
        \' |                 |  | This is          |  |  zEnter            | ',
        \' |                 |  |  the | test      |  |                    | ',
        \' | M               |  |   paragraph      |  |                    | ',
        \' |                 |  | }                |  |                    | ',
        \' |                 |  | }                |  | == zz ====         | ',
        \' | L               |  | This is          |  |                    | ',
        \' |                 |  |  the test        |  |                    | ',
        \'  -----------------   |   paragraph      |  |                    | ',
        \'                      | }                |  | == z- =====        | ',
        \'  { ...up paragraph   |                  |  |                    | ',
        \'  } ...down paragraph  ------------------    --------------------  ',
        \],#{title: ' cursor jump in window ',
        \border: [], zindex: 1,
        \line: 49,
        \col: &columns - 71
        \})
    cal matchaddpos("Identifier", [[4,4],[4,25]], 16, -1, #{window: s:training_popup_window2_winid})
    cal matchaddpos("Identifier", [[5,48,6]], 16, -1, #{window: s:training_popup_window2_winid})
    cal matchaddpos("Identifier", [[7,4]], 16, -1, #{window: s:training_popup_window2_winid})
    cal matchaddpos("Identifier", [[8,25]], 16, -1, #{window: s:training_popup_window2_winid})
    cal matchaddpos("Identifier", [[9,25],[9,50,2]], 16, -1, #{window: s:training_popup_window2_winid})
    cal matchaddpos("Identifier", [[10,4]], 16, -1, #{window: s:training_popup_window2_winid})
    cal matchaddpos("Identifier", [[13,25],[13,50,2]], 16, -1, #{window: s:training_popup_window2_winid})
    cal matchaddpos("Comment", [[5,25,7],[6,26,3],[6,32,4],[7,27,9]], 16, -1, #{window: s:training_popup_window2_winid})
    cal matchaddpos("Comment", [[10,25,7],[11,26,8],[12,27,9]], 16, -1, #{window: s:training_popup_window2_winid})
endf

fu! s:trainingPopupWindow2SampleMv(timer)
    execute("norm gg")
    cal cursor(15, 1)
    cal timer_start(200, function('s:trainingPopupWindow2SampleMv1'))
    cal timer_start(800, function('s:trainingPopupWindow2SampleMv2'))
    cal timer_start(1400, function('s:trainingPopupWindow2SampleMv3'))
    cal timer_start(2200, function('s:trainingPopupWindow2SampleMv4'))
    cal timer_start(2600, function('s:trainingPopupWindow2SampleMv4'))
    cal timer_start(3400, function('s:trainingPopupWindow2SampleMv5'))
    cal timer_start(4200, function('s:trainingPopupWindow2SampleMv6'))
    cal timer_start(4500, function('s:trainingPopupWindow2SampleMv7'))
endf
fu! s:trainingPopupWindow2SampleMv1(timer)
    execute("norm H")
    echo("H   window High")
endf
fu! s:trainingPopupWindow2SampleMv2(timer)
    execute("norm L")
    echo("L   window Low")
endf
fu! s:trainingPopupWindow2SampleMv3(timer)
    execute("norm M")
    echo("M   window Middle")
endf
fu! s:trainingPopupWindow2SampleMv4(timer)
    execute("norm }")
    echo("}   next paragraph")
endf
fu! s:trainingPopupWindow2SampleMv5(timer)
    execute "norm z\<CR>"
    echo("z+Enter   stay cursor, top")
endf
fu! s:trainingPopupWindow2SampleMv6(timer)
    execute("norm zz")
    echo("zz   stay cursor, middle")
endf
fu! s:trainingPopupWindow2SampleMv7(timer)
    echo("")
endf

" insert mode
fu! s:trainingPopupMode1(timer)
    let s:training_popup_mode1_winid = popup_create([
        \' -[insert_in_row]------------ ',
        \' I       i a              A ',
        \'  This is | the test text.  ',
        \'       cursor     ',
        \' -[insert_up/down_row]------- ',
        \'  O ',
        \'  This is | the test text.  ',
        \'  o     cursor      ',
        \' -[insert_completion]------- ',
        \' C-p      | completion ',
        \],#{title: ' INSERT (Esc NORMAL) ',
        \border: [], zindex: 1,
        \line: 49,
        \col: &columns - 105
        \})
    cal matchaddpos("Identifier", [2,6,[8,3],[10,2,3]], 16, -1, #{window: s:training_popup_mode1_winid})
    cal matchaddpos("Comment", [[3,3,7],[3,13,14],[7,3,7],[7,13,14]], 16, -1, #{window: s:training_popup_mode1_winid})
endf

" command mode
fu! s:trainingPopupMode2(timer)
    let s:training_popup_mode2_winid = popup_create([
        \' :w      | save file',
        \' :q      | quit',
        \' :wq     | savee & quiut',
        \' :smile  | something will happen',
        \' :echo "Hello Vim!!"  | use command in vim',
        \' :!echo "Hello Vim!!" | use command in shell ',
        \' :TrainingWheelsProtocol 0   | quit tutorial',
        \],#{title: ' COMMAND (Esc NORMAL) ',
        \border: [], zindex: 1,
        \line: 49,
        \col: 5
        \})
    cal matchaddpos("Identifier", [[1,2,2],[2,2,2],[3,2,3],[4,2,6],[5,2,19],[6,2,20]], 16, -1, #{window: s:training_popup_mode2_winid})
endf

fu! s:trainingPopupMode2SampleMv(timer)
    cal timer_start(400, function('s:trainingPopupMode2SampleMv1'))
endf
fu! s:trainingPopupMode2SampleMv1(timer)
    echo("Hello Vim!!")
endf

" search
fu! s:trainingPopupSearch(timer)
    let s:training_popup_search_winid = popup_create([
        \' *   | search current cursor word ',
        \' #   | search current cursor word(reverse) ',
        \' n   | next hit',
        \' N   | prev hit',
        \' /word  | search free word',
        \' :noh   | clear highlight',
        \],#{title: ' Search (NORMAL MODE) ',
        \border: [], zindex: 1,
        \line: 49,
        \col: 53
        \})
    cal matchaddpos("Identifier", [[1,2],[2,2],[3,2],[4,2],[5,2,5],[6,2,4]], 16, -1, #{window: s:training_popup_search_winid})
endf

fu! s:trainingPopupSearchSampleMv(timer)
    execute("norm gg")
    cal cursor(15, 9)
    cal timer_start(200, function('s:trainingPopupSearchSampleMv1'))
    cal timer_start(800, function('s:trainingPopupSearchSampleMv2'))
    cal timer_start(1200, function('s:trainingPopupSearchSampleMv2'))
    cal timer_start(1600, function('s:trainingPopupSearchSampleMv3'))
endf
fu! s:trainingPopupSearchSampleMv1(timer)
    cal feedkeys("\/test\<CR>")
endf
fu! s:trainingPopupSearchSampleMv2(timer)
    cal feedkeys("n")
endf
fu! s:trainingPopupSearchSampleMv3(timer)
    cal feedkeys("N")
endf

" operator + textobject
fu! s:trainingPopupOpeObj(timer)
    let s:training_popup_opeobj_winid = popup_create([
        \' -[operator]--------------------------------------- ',
        \' v    | choose (VISUAL MODE) ',
        \' S-v  | choose row (VISUAL MODE) ',
        \' y    | yank (copy) ',
        \' p P  | past left, past right ',
        \' x    | cut ',
        \' d    | delete ',
        \' c    | change (cut & INSERT MODE) ',
        \' -[textobject]------------------------------------- ',
        \' iw   | inner word',
        \' i"   | inner "" (any pair char) ',
        \' a"   | include ""  ',
        \' is   | inner sentence  ',
        \' ip   | inner paragraph  ',
        \' -[sample]----------------------------------------- ',
        \'  "This is | the test text."  ',
        \'        cursor        ',
        \' vi"y | chose "This is the test text." and copy',
        \' yi"  | copy "This is the test text." (same)',
        \],#{title: ' operator & textobject ',
        \border: [], zindex: 1,
        \line: 9,
        \col: &columns - 100
        \})
    cal matchaddpos("Identifier", [[2,2],[3,2,3],[4,2],[5,2,3],[6,2],[7,2],[8,2]], 16, -1, #{window: s:training_popup_opeobj_winid})
    cal matchaddpos("Identifier", [[10,2,2],[11,2,2],[12,2,2],[13,2,2],[14,2,2]], 16, -1, #{window: s:training_popup_opeobj_winid})
    cal matchaddpos("Comment", [[16,3,8],[16,14,15]], 16, -1, #{window: s:training_popup_opeobj_winid})
    cal matchaddpos("Identifier", [[18,2,4],[19,2,3]], 16, -1, #{window: s:training_popup_opeobj_winid})
endf

fu! s:trainingPopupOpeObjSampleMv(timer)
    cal cursor(52, 13)
    execute("norm zz")
    cal timer_start(200, function('s:trainingPopupOpeObjSampleMv1'))
    cal timer_start(800, function('s:trainingPopupOpeObjSampleMv2'))
    cal timer_start(1500, function('s:trainingPopupOpeObjSampleMv3'))
    cal timer_start(1600, function('s:trainingPopupOpeObjSampleMv4'))
    cal timer_start(2200, function('s:trainingPopupOpeObjSampleMv5'))
    cal timer_start(2900, function('s:trainingPopupOpeObjSampleMv3'))
endf
fu! s:trainingPopupOpeObjSampleMv1(timer)
    echo("vi<   visual inner <>")
endf
fu! s:trainingPopupOpeObjSampleMv2(timer)
    execute("norm vi<")
endf
fu! s:trainingPopupOpeObjSampleMv3(timer)
    execute "norm \<Esc>"
    cal cursor(72, 6)
    execute("norm zz")
endf
fu! s:trainingPopupOpeObjSampleMv4(timer)
    echo("vis   visual inner statement")
endf
fu! s:trainingPopupOpeObjSampleMv5(timer)
    execute("norm vis")
endf

" undo redo repeat
fu! s:trainingPopupTips(timer)
    if s:training_popup_tips_win_flg == 0
        retu
    endif
    cal popup_close(s:training_popup_tips_winid)
    let s:training_popup_tips_winid = popup_create([
        \' u   | undo ',
        \' C-r | redo ',
        \' .   | repeat ',
        \],#{title: ' Tips ',
        \border: [], zindex: 1,
        \line: 'cursor+1',
        \col: 'cursor+1'
        \})
    cal matchaddpos("Identifier", [[1,2],[2,2,3],[3,2]], 16, -1, #{window: s:training_popup_tips_winid})
endf

" add cursor hold
fu! s:trainingPopupTipsCursor(timer)
    let s:training_popup_tips_win_flg = 1
    aug training_tips_popup
        au!
        au CursorHold * silent cal s:trainingPopupTipsOpen()
        au CursorMoved * silent cal s:trainingPopupTipsClose()
        au CursorMovedI * silent cal s:trainingPopupTipsClose()
    aug END
endf

fu! s:trainingPopupTipsOpen()
    cal timer_stop(s:training_popup_tips_win_tid)
    let s:training_popup_tips_win_tid = timer_start(300, function('s:trainingPopupTips'))
endf
fu! s:trainingPopupTipsClose()
    cal timer_stop(s:training_popup_tips_win_tid)
    cal popup_close(s:training_popup_tips_winid)
endf


let g:training_wheels_practice_file = []

" create practice file
fu! s:trainingWheelsPracticeFileCreate()
    let repo = 'https://raw.githubusercontent.com/serna37/vim-tutorial/master/practice.md'
    let cmd = 'curl '.repo.' > ~/practice.md'
    cal job_start(["/bin/sh","-c",cmd], {'close_cb': function('s:trainingWheelsPracticeFileOpen')})
endf

" open practice file (only tutorial)
fu! s:trainingWheelsPracticeFileOpen(ch) abort
    execute('tabe ~/practice.md')
    cal cursor(26, 6)
endf

