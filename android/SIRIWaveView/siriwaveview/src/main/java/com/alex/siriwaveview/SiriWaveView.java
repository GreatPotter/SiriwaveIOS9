package com.alex.siriwaveview;

import android.animation.ObjectAnimator;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.RadialGradient;
import android.graphics.Shader;
import android.util.AttributeSet;
import android.view.View;

import com.alex.siriwaveview.SiriWaveCurve;

import java.util.Random;

/**
 * Created by Alex on 6/25/2016.
 */
public class SiriWaveView extends View {

    private SiriWaveCurve[] curves;
    private Path mPath;
    private Paint mPaint;

    public float intensity;
    public float speed;
    public int[] colors;
    public float frequency = 1.5f;
    public float amplitude;

    ObjectAnimator mAmplitudeAnimator;

    public SiriWaveView(Context context) {
        super(context);
//        if (!isInEditMode())
//            init(context, null);
    }

    public SiriWaveView(Context context, AttributeSet attrs) {
        super(context, attrs);
//        if (!isInEditMode())
//            init(context, attrs);
    }

    public SiriWaveView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
//        if (!isInEditMode())
//            init(context, attrs);
    }

    public void init(Context context, AttributeSet attrs) {
        TypedArray a = context.obtainStyledAttributes(attrs, com.alex.siriwaveview.R.styleable.SiriWaveView);
        frequency = a.getFloat(com.alex.siriwaveview.R.styleable.SiriWaveView_waveFrequency, frequency);
        speed = a.getFloat(R.styleable.SiriWaveView_speed, speed);
        intensity = a.getFloat(R.styleable.SiriWaveView_intensity, intensity);

        mPath = new Path();
        mPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        mPaint.setStyle(Paint.Style.STROKE);
        mPaint.setStrokeWidth(2);
        mPaint.setColor(Color.WHITE);

        a.recycle();
        initAnimation();
    }

    public void configure() {
        Random r = new Random();
        int length = this.colors.length * (r.nextInt(2) + 1);
        this.curves = new SiriWaveCurve[length];

        for (int i = 0; i < length; i++)
            this.curves[i] = new SiriWaveCurve();
    }

    private void initAnimation() {
        if (mAmplitudeAnimator == null) {
            mAmplitudeAnimator = ObjectAnimator.ofFloat(this, "amplitude", .1f);
            mAmplitudeAnimator.setRepeatCount(ObjectAnimator.INFINITE);
        }
        if (!mAmplitudeAnimator.isRunning()) {
            mAmplitudeAnimator.start();
        }
    }

    @Override
    protected void onDraw(Canvas canvas) {
        updateAmplitude();

        mPath.reset();

        float width = canvas.getWidth();
        float height = canvas.getHeight();
        float height2 = height / 2.0f;
        float width2 = width / 2.0f;
        float width4 = width / 4.0f;
        float maxAmplitude = height2 - 2;

        for (int i = 0; i < this.curves.length; i++) {

            this.curves[i].changeTick();

            SiriWaveCurve curve = this.curves[i];
            float xBase = width2 + (-width4 + curve.seed * width2);
            float yBase = height2;

            float t_amplitude = (float) (this.amplitude / (Math.abs(width2 - xBase) / width4 + 1.0f));
            float x, y, xInit = 10000000;
            for (float j = -3; j <= 3; j += 0.01) {
                x = xBase + j * width4;
                y = yBase + this.curves[i]._ypos(j, t_amplitude, maxAmplitude);

                xInit = Math.min(xInit, x);

                if (j == -3) {
                    mPath.moveTo(x, y);
                } else {
                    mPath.lineTo(x, y);
                }
            }
            mPath.lineTo(xInit, yBase);

            xInit = 10000000;
            for (float j = -3; j <= 3; j += 0.01) {
                x = xBase + j * width4;
                y = yBase - this.curves[i]._ypos(j, t_amplitude, maxAmplitude);

                xInit = Math.min(xInit, x);

                if (j == -3) {
                    mPath.moveTo(x, y);
                } else {
                    mPath.lineTo(x, y);
                }
            }

            mPath.lineTo(xInit, yBase);

            float h = Math.abs(this.curves[i]._ypos(0, t_amplitude, maxAmplitude));

            mPaint.setStyle(Paint.Style.FILL);

            float shaderCx = xBase;
            float shaderCy = yBase;
            int red =   (colors[i%3] >> 16) & 0xFF;
            int green = (colors[i%3] >> 8) & 0xFF;
            int blue =  (colors[i%3] >> 0) & 0xFF;
            int col1 = Color.argb(100, red, green, blue);
            int col2 = Color.argb(50, red, green, blue);
            int []cols = {col1, col2};
            float []stops = {0, 1};

            mPaint.setAntiAlias(true);
            Shader radialGradientShader;

            radialGradientShader = new RadialGradient(
                    shaderCx, shaderCy, (float) (width2),
                    cols, stops,
                    Shader.TileMode.CLAMP);
            mPaint.setShader(radialGradientShader);

            canvas.drawPath(mPath, mPaint);
        }
    }

    private void updateAmplitude() {
        float speed = (float) 0.1;
        if (Math.abs(this.amplitude - this.intensity) < speed) {
            this.amplitude = this.intensity;
        } else {
            if (this.amplitude < this.intensity) {
                this.amplitude += speed;
            } else {
                this.amplitude -= speed;
            }
        }
    }

    private void setAmplitude(float amplitude) {
        this.amplitude = 1f;
        invalidate();
    }

    private float getAmplitude() {
        return this.amplitude;
    }

    public void stopAnimation() {
        if (mAmplitudeAnimator != null) {
            mAmplitudeAnimator.removeAllListeners();
            mAmplitudeAnimator.end();
            mAmplitudeAnimator.cancel();
        }
    }

    public void startAnimation() {
        if (mAmplitudeAnimator != null) {
            mAmplitudeAnimator.start();
        }
    }

    public void setWaveColor(int waveColor) {
        mPaint.setColor(waveColor);
        invalidate();
    }

    public void setStrokeWidth(float strokeWidth) {
        mPaint.setStrokeWidth(strokeWidth);
        invalidate();
    }
}