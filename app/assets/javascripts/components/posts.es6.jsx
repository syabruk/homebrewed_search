class Posts extends React.Component {
  render() {
  	var showPosts = (post) => <Post title={post.title} body={post.body} highlights={post.highlights} key={post.id} id={post.id}/>;
  	return (
      <div className="card-columns">
        {this.props.posts.map(showPosts)}
      </div>
    );
  }
}
