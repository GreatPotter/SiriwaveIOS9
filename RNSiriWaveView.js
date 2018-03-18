import React, { Component } from "react";
import { StyleSheet, ViewPropTypes, Platform } from "react-native";
import PropTypes from "prop-types";

import { requireNativeComponent } from "react-native";

class RNSiriWaveView extends Component {
  constructor(props) {
    super(props)
  }

  render() {
      return <SiriWaveView style={{ width: this.props.width, height: this.props.height }} 
        props={{
          intensity : this.props.intensity,
          speed: this.props.speed,
          colors : this.props.colors,
          width: this.props.width,
          height: this.props.height,
          backgroundColor: this.props.backgroundColor,
          frequency: this.props.frequency,
          amplitude: this.props.amplitude,
        }}
        startAnimation={this.props.startAnimation} stopAnimation={this.props.stopAnimation}
      />;
  }
}

RNSiriWaveView.propTypes = {
  ...ViewPropTypes,

  intensity : PropTypes.number,
  colors : PropTypes.arrayOf(PropTypes.string),

  speed : PropTypes.number,

  width: PropTypes.number,
  height: PropTypes.number,
  props: PropTypes.object,

  amplitude: PropTypes.number,
  backgroundColor: PropTypes.string,
  frequency: PropTypes.number,

  startAnimation: PropTypes.bool,
  stopAnimation: PropTypes.bool
};

RNSiriWaveView.defaultProps = {
  width: 200,
  height: 100,

  colors : ['#2085fc', '#5efca9', '#fd4767'],
  intensity : 0.3,
  speed: 0.05,

  backgroundColor: '#FFFFFF',
  frequency: 1.5,
  amplitude: 0.01,

  startAnimation: false,
  stopAnimation: false
};

const SiriWaveView = requireNativeComponent(
  "RNSiriWaveView",
  RNSiriWaveView
);

export default RNSiriWaveView;
