ready = ->
  $(window).scroll ->
    element = $('#page-top-btn')
    # DIVE05 課題: ブログ一覧画面のトップに戻るボタンを ID で取得
    elementBlog = $('#blog-top-btn')

    visible = element.is(':visible')
    # DIVE05 課題: ボタンの表示の判定
    visibleBlog = elementBlog.is(':visible')

    height = $(window).scrollTop()
    if height > 400
      element.fadeIn() if !visible
    else
      element.fadeOut()

    # DIVE05 課題: トップから 200px ↓で非表示の場合は fadeIn、それ以外は fadeOut
    if height > 200
      elementBlog.fadeIn() if !visibleBlog
    else
      elementBlog.fadeOut()
    
  $(document).on 'click', '#move-page-top', ->
    $('html, body').animate({ scrollTop: 0 }, 'slow')
      
$(document).ready(ready)
$(document).on('page:load', ready)