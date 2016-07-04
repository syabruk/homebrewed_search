class CreatePostModal extends React.Component {
  componentDidMount() {
    var modalNode = ReactDOM.findDOMNode(this);
    $(modalNode).modal('show');
    $(modalNode).on('hidden.bs.modal', this.props.handleHideModal);
  }

  onFieldChange(event) {
    var state = {};
    state[event.target.name] = $.trim(event.target.value);
    this.setState(state);
  }

  onSuccessPost(data) {
    var modalNode = ReactDOM.findDOMNode(this);
    $(modalNode).modal('hide');
    this.props.addPost(data);
  }

  handleSubmit(event) {
    event.preventDefault();

    var data = {
      title: this.state.title,
      body: this.state.body
    };

    $.ajax({
      type: 'POST',
      url: '/posts.json',
      data: { post: data }
    })
    .done(function(data) {
      this.onSuccessPost(data)
    }.bind(this))
    .fail(function(jqXhr) {
      console.log('Failed on creation');
    });
  }

  render() {
  	return (
      <div className="modal fade">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              <button type="button" className="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h4 className="modal-title">New post</h4>
            </div>
            <form action="" onSubmit={this.handleSubmit.bind(this)}>
              <div className="modal-body">
                <fieldset className="form-group">
                  <input onChange={this.onFieldChange.bind(this)} name="title" type="text" className="form-control" placeholder="Title" />
                </fieldset>
                <fieldset className="form-group">
                  <textarea onChange={this.onFieldChange.bind(this)} name="body" type="text" className="form-control" rows="10" placeholder="Body" />
                </fieldset>
              </div>
              <div className="modal-footer">
                <button type="button" className="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" type="submit" className="btn btn-primary">Save</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    )
  }
}

CreatePostModal.propTypes = {
  addPost: React.PropTypes.func.isRequired,
  handleHideModal: React.PropTypes.func.isRequired
}
