class PostsContainer extends React.Component {
  constructor() {
    super();
    this.state = { posts: [] };
  }

  componentWillMount(){
    this.fetchPosts();
  }

  fetchPosts(url) {
    $.ajax({
      url: url || this.props.postsPath,

      dataType: 'json',

      success: function(data) {
        this.setState({posts: data});
      }.bind(this),

      error: function(data) {
        this.setState({posts: []});
      }.bind(this)
    });
  }

  searchPosts(event) {
    if (event.target.value) {
      var url = this.props.postsPath + "?query=" + event.target.value;
      this.fetchPosts(url);
    }
    else{
      this.fetchPosts();
    }
  }

  render() {
    return (
      <div>
        <PostsSearch postsPath={this.props.postsPath} submitHandler={this.searchPosts.bind(this)}/>
        <Posts posts={this.state.posts} />
      </div>
    );
  }
}

PostsContainer.propTypes = {
  postsPath: React.PropTypes.string
}
