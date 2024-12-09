import PropTypes from 'prop-types';
import React, { Component } from 'react';

export default class ParagraphLimit extends Component {
  static propTypes = {
    text: PropTypes.string.isRequired, 
    limit: PropTypes.number.isRequired 
  };

  render() {
    const { text, limit } = this.props;

    return (
      <p className="card-text">
        {text.length > limit ? text.slice(0, limit) + '...' : text}
      </p>
    );
  }
}