package ui.siriwave;

import android.app.Activity;
import android.graphics.Color;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.ViewGroupManager;

import com.alex.siriwaveview.SiriWaveView;
import com.facebook.react.uimanager.annotations.ReactProp;

/**
 * Created by user on 26/01/18.
 */

public class RNSiriWaveView extends ViewGroupManager<ViewGroup> {

    public static final String REACT_CLASS = "RNSiriWaveView";
    private Activity activity;

    @Override
    public String getName() {
        return REACT_CLASS;
    }


    @Override
    protected FrameLayout createViewInstance(final ThemedReactContext reactContext) {
        activity = reactContext.getCurrentActivity();

        return new FrameLayout(reactContext.getCurrentActivity());
    }

    @ReactProp(name = "props")
    public void setProps(FrameLayout siriWaveViewFrame, ReadableMap props) {
        int width = props.getInt("width");
        int height = props.getInt("height");

        String backgroundColor = props.getString("backgroundColor");

        double frequency = props.getDouble("frequency");
        double amplitude = props.getDouble("amplitude");
        double speed = props.getDouble( "speed");
        double intensity = props.getDouble("intensity");

        ReadableArray colors = props.getArray("colors");
        int[] cols = new int[colors.size()];
        for (int i = 0 ; i < colors.size(); i++) {
            cols[i] = Color.parseColor(colors.getString(i));
        }

        SiriWaveView siriWaveView = new SiriWaveView(activity);

        siriWaveView.frequency = Double.valueOf(frequency).floatValue();
        siriWaveView.amplitude = Double.valueOf(amplitude).floatValue();
        siriWaveView.speed = Double.valueOf(speed).floatValue();
        siriWaveView.intensity = Double.valueOf(intensity).floatValue();
        siriWaveView.colors = cols;
        siriWaveView.init(activity, null);

        siriWaveView.configure();
        siriWaveViewFrame.addView(siriWaveView);
    }


    @ReactProp(name = "startAnimation")
    public void setStartAnimation(FrameLayout SiriWaveViewFrame, boolean startAnimation) {
        SiriWaveView siriWaveView = (SiriWaveView) SiriWaveViewFrame.getChildAt(0);
        if (startAnimation) {
            siriWaveView.startAnimation();
        }
    }

    @ReactProp(name = "stopAnimation")
    public void setStopAnimation(FrameLayout SiriWaveViewFrame, boolean stopAnimation) {
        SiriWaveView siriWaveView = (SiriWaveView) SiriWaveViewFrame.getChildAt(0);
        if (stopAnimation) {
            siriWaveView.stopAnimation();
        }
    }
}
