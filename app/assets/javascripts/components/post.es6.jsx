class Post extends React.Component {
  render () {
    return (
      <div className="card card-block">
        <h4 className="card-title">{this.props.title}</h4>
        <p className="card-text">{this.props.body}</p>
        <p className="card-text"><small className="text-muted">Last updated 3 mins ago</small></p>
      </div>
    );
  }
}

Post.propTypes = {
  id: React.PropTypes.number,
  title: React.PropTypes.string,
  body: React.PropTypes.string
}
