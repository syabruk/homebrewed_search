class PostsSearch extends React.Component {
  constructor() {
    super();
    this.debouncedHandleChange = _.flowRight(_.debounce(this.handleChange, 250), _.clone);
  }

  handleChange(event) {
    this.props.submitHandler(event);
  }

  handleKeyDown(event) {
    if (event.key === 'Enter') {
      event.preventDefault();
      this.handleChange(event);
    }
  }

  render () {
		return (
			<form>
				<p>
          <input name="query" className="form-control form-control-lg" placeholder="Search query" onKeyDown={ this.handleKeyDown.bind(this) } onChange={ this.debouncedHandleChange.bind(this) } />
        </p>
			</form>
		);
	}
}

PostsSearch.propTypes = {
  postsPath: React.PropTypes.string,
  submitHandler: React.PropTypes.func
}
