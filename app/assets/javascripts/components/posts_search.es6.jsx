class PostsSearch extends React.Component {
  constructor() {
    super();
    this.handleChange = _.flowRight(_.debounce(this.handleChange, 250), _.clone);
  }

  handleChange(event) {
    return this.props.submitHandler(event);
  }

  render () {
		return (
			<form action={ this.props.postsPath } acceptCharset="UTF-8" method="get">
				<p>
          <input name="query" className="form-control form-control-lg" placeholder="Search query" onChange={ this.handleChange.bind(this) } />
        </p>
			</form>
		);
	}
}

PostsSearch.propTypes = {
  postsPath: React.PropTypes.string,
  submitHandler: React.PropTypes.func
}
