class CreatePostButton extends React.Component {
  constructor() {
    super();
    this.state = {view: {showModal: false}};
  }

  handleHideModal() {
  	this.setState({view: {showModal: false}})
  }

  handleShowModal() {
  	this.setState({view: {showModal: true}})
  }

  render () {
    return (
      <div>
    		<div className="text-xs-right">
          <button className="btn btn-primary-outline" onClick={this.handleShowModal.bind(this)}>New post</button>
        </div>
        {this.state.view.showModal ? <CreatePostModal handleHideModal={this.handleHideModal.bind(this)} addPost={this.props.addPost}/> : null}
    	</div>
    )
  }
}

CreatePostButton.propTypes = {
  addPost: React.PropTypes.func.isRequired
}
