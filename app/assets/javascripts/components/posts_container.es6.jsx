class PostsContainer extends React.Component {
  constructor() {
    super()
    this.state = { posts: [] }
    return
  }

  componentWillMount(){
    this.fetchPosts();
  }

  fetchPosts() {
    $.ajax({
      url: this.props.postsPath,

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
      $.ajax({
        url: this.props.postsPath + "?query=" + event.target.value,

        dataType: 'json',

        success: function(data) {
          this.setState({posts: data});
        }.bind(this),

        error: function(data) {
          this.setState({posts: []});
        }.bind(this)
      });
    }
    else{
      this.fetchPosts();
    }
  }

  render() {
    return (
      <div>
        <PostsSearch postsPath={this.props.postsPath} submitPath={this.searchPosts.bind(this)}/>
        <Posts posts={this.state.posts} />
      </div>
    );
  }
}

PostsContainer.propTypes = {
  postsPath: React.PropTypes.string
}
