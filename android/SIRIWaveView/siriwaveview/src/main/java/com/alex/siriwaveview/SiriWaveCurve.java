package com.alex.siriwaveview;

import java.util.Random;

/**
 * Created by harrypotter on 3/18/18.
 */

public class SiriWaveCurve {

    public float tick;
    public float amplitude;
    public float seed;
    public float openClass;

    public SiriWaveCurve() {
        tick = 0;
    }
    private void respawn() {
        Random r = new Random();
        this.amplitude = (float) (0.3 + r.nextFloat() * 0.7);
        this.seed = r.nextFloat();
        this.openClass = (float) (2 + Math.floor(r.nextFloat()*3));
    }

    public float _ypos(float i, float amplitude, float maxAmplitude)
    {
        float p = this.tick;
        float y = (float) (-1 * Math.abs(Math.sin(p)) * amplitude * this.amplitude * maxAmplitude * Math.pow(1 / (1 + Math.pow(this.openClass * i, 2)), 2));

        if (Math.abs(y) < 0.001) {
            this.respawn();
        }

        return y;
    }

    public void changeTick()
    {
        this.tick += 0.2 * (1 - 0.5 * Math.sin(this.seed * Math.PI));
    }

}
