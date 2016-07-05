class Post extends React.Component {
  componentDidMount() {
    this.highlight();
  }

  componentWillUnmount() {
    this.removeHighlight();
  }

  componentDidUpdate() {
    this.removeHighlight();
    this.highlight();
  }

  shouldHighlight() {
    return Array.isArray(this.props.highlights);
  }

  highlight() {
    if (this.shouldHighlight()) {
      this.card().mark(this.props.highlights, { accuracy: 'complementary' });
    }
  }

  removeHighlight() {
    this.card().unmark();
  }

  card() {
    return $('#' + this.divId())
  }

  divId() {
    return "post_" + this.props.id
  }

  render () {
    return (
      <div className="card card-block" id={this.divId()}>
        <h4 className="card-title">{this.props.title}</h4>
        <p className="card-text">{this.props.body}</p>
      </div>
    );
  }
}

Post.propTypes = {
  id: React.PropTypes.number,
  title: React.PropTypes.string,
  body: React.PropTypes.string,
  highlights: React.PropTypes.array
}
