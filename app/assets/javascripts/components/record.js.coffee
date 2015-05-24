@Record = React.createClass
  getInitialState: ->
    edit: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  submitEdit: ->
    data =
      title: React.findDOMNode(@refs.title).value
      amount: React.findDOMNode(@refs.amount).value
      date: React.findDOMNode(@refs.date).value
    $.ajax
      method: "PUT"
      url: "/records/#{ @props.record.id }"
      dataType: "JSON"
      data:
        record: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.record, data
  handleEdit: (e) ->
    e.preventDefault()
    @submitEdit()
  handleEnterKeydown: (e) ->
    if e.keyCode is 13
      @submitEdit()
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: "DELETE"
      url: "/records/#{ @props.record.id }"
      dataType: "JSON"
      success: () =>
        @props.handleDeleteRecord @props.record
  recordRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.record.date
      React.DOM.td null, @props.record.title
      React.DOM.td null, amountFormat(@props.record.amount)
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-primary'
          onClick: @handleToggle
          'Edit'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'
  recordForm: ->
    React.DOM.tr null,
       React.DOM.td null,
         React.DOM.input
           className: 'form-control'
           onKeyUp: @handleEnterKeydown
           type: 'text'
           defaultValue: @props.record.date
           ref: 'date'
       React.DOM.td null,
         React.DOM.input
           className: 'form-control'
           onKeyUp: @handleEnterKeydown
           type: 'text'
           defaultValue: @props.record.title
           ref: 'title'
       React.DOM.td null,
         React.DOM.input
           className: 'form-control'
           onKeyUp: @handleEnterKeydown
           type: 'number'
           defaultValue: @props.record.amount
           ref: 'amount'
       React.DOM.td null,
         React.DOM.a
           className: 'btn btn-default'
           onClick: @handleEdit
           'Update'
         React.DOM.a
           className: 'btn btn-danger'
           onClick: @handleToggle
           'Cancel'
  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
