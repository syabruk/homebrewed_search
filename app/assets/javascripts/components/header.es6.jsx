class Header extends React.Component {
  render () {
    return (
      <nav className="navbar navbar-light bg-faded">
        <div className="row">
          <div id="navbar-header" className="col-md-10">
            <span className="navbar-brand">Homebrewed Search</span>
          </div>
          <div className="col-md-2">
            <CreatePostButton addPost={this.props.addPost}/>
          </div>
        </div>
      </nav>
    );
  }
}

Header.propTypes = {
  addPost: React.PropTypes.func
}
