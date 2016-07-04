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
			<div>
				<form ref="form" action={ this.props.postsPath } acceptCharset="UTF-8" method="get">
  				<p><input ref="query" name="query" placeholder="Search here." onChange={ this.handleChange.bind(this) } /></p>
				</form>
			</div>
		);
	}
}

PostsSearch.propTypes = {
  postsPath: React.PropTypes.string,
  submitHandler: React.PropTypes.func
}
