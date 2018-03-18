/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
} from 'react-native';

import RNSiriWaveView from 'react-native-siri-wave-view'

export default class App extends Component<{}> {
  constructor (props) {
    super(props)

    this.state = {
      startAnimation: false
    }
  }

  componentDidMount () {
   
    this.setState({ startAnimation: true, stopAnimation: false });
  }

  render() {
    return (
      <View style={styles.container}>
        <RNSiriWaveView intensity = {0.3} 
          backgroundColor = {"#000"}
          colors = {['#2085fc', '#5efca9', '#fd4767']}
<<<<<<< HEAD
          speed = {0.05}
=======
          speed = {0.08}
>>>>>>> 0613abefb0528881f6caad3377566447ab77a3a2
          width={400} 
          height={100} 
          startAnimation={this.state.startAnimation} 
          stopAnimation={this.state.stopAnimation} 
          amplitude = {1}/>
      </View>
    );
  }
}


const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: "row",
    justifyContent: "space-around",
    alignItems: "center",
    backgroundColor: "#000"
  }
});