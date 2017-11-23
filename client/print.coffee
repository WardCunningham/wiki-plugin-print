
expand = (text)->
  text
    .replace /&/g, '&amp;'
    .replace /</g, '&lt;'
    .replace />/g, '&gt;'
    .replace /\*(.+?)\*/g, '<i>$1</i>'

contents = (pattern) ->
   r = wiki.neighborhoodObject.search pattern
   console.log JSON.stringify r, null, '  '
   ("<li data-site=#{info.site} data-slug=#{info.page.slug}>" + wiki.resolveLinks "[[#{info.page.title}]]" for info in r.finds).join ''

emit = ($item, item) ->
  $item.append """
    <div style="background-color:#eee;padding:15px;">
      #{contents item.text}
      <center><button>print</button></center>
    </div>
  """

bind = ($item, item) ->
  $item.dblclick -> wiki.textEditor $item, item

  $item.find('button').click (evt) ->
    list = $item.find('li').map (i,item) ->
      "#{$(item).data('site')} #{$(item).data('slug')}"
    # wiki.dialog 'to be printed', "<pre>#{list.toArray().join "\n"}</pre>"
    w = window.open()
    w.document.write "<pre>#{list.toArray().join "\n"}</pre>"
    w.window.print()
    w.document.close()

  $('body').on 'new-neighbor-done', (e, site) ->
    $item.empty()
    emit $item, item
    bind $item, item



window.plugins.print = {emit, bind} if window?
module.exports = {expand} if module?

