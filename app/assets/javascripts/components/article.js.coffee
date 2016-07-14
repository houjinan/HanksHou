@Article = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.article.title
      React.DOM.td null, @props.article.content