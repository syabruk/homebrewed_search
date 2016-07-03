class PostsSearch extends React.Component {
  render () {
		return (
			<div>
				<form ref="form" action={ this.props.postsPath } acceptCharset="UTF-8" method="get">
  				<p><input ref="query" name="query" placeholder="Search here." onChange={ this.props.submitPath } /></p>
				</form>
			</div>
		);
	}
}
