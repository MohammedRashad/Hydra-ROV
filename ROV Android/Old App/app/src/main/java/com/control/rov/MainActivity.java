package com.control.rov;


import android.content.Context;
import android.os.Bundle;
import android.os.Vibrator;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.widget.Button;


public class MainActivity extends AppCompatActivity {


    Button open, close, up, down, left, right, armr, arml, forward, backward;
    Vibrator vb;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        //Initialize components
        define();

        vb = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);

        open.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        // PRESSED

                        Log.d("ROV", "open1");
                        open.setTextColor(0xffffc107);
                        vb.vibrate(300);

                        return true; // if you want to handle the touch event
                    case MotionEvent.ACTION_UP:
                        // RELEASED

                        Log.d("ROV", "open0");
                        open.setTextColor(0xffffffff);


                        return true; // if you want to handle the touch event
                }
                return false;
            }
        });


        close.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        // PRESSED

                        Log.d("ROV", "close1");
                        close.setTextColor(0xffffc107);


                        vb.vibrate(300);
                        return true; // if you want to handle the touch event
                    case MotionEvent.ACTION_UP:
                        // RELEASED

                        Log.d("ROV", "close0");
                        close.setTextColor(0xffffffff);


                        return true; // if you want to handle the touch event
                }
                return false;
            }
        });


        up.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        // PRESSED

                        Log.d("ROV", "up1");

                        up.setTextColor(0xffffc107);
                        vb.vibrate(300);


                        return true; // if you want to handle the touch event
                    case MotionEvent.ACTION_UP:
                        // RELEASED

                        Log.d("ROV", "up0");
                        up.setTextColor(0xffffffff);


                        return true; // if you want to handle the touch event
                }
                return false;
            }
        });


        forward.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        // PRESSED

                        Log.d("ROV", "forwardd");
                        forward.setTextColor(0xffffc107);
                        vb.vibrate(300);


                        return true; // if you want to handle the touch event
                    case MotionEvent.ACTION_UP:
                        // RELEASED

                        Log.d("ROV", "forward0");
                        forward.setTextColor(0xffffffff);


                        return true; // if you want to handle the touch event
                }
                return false;
            }
        });


        backward.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        // PRESSED

                        Log.d("ROV", "backwardd");
                        backward.setTextColor(0xffffc107);

                        vb.vibrate(300);

                        return true; // if you want to handle the touch event
                    case MotionEvent.ACTION_UP:
                        // RELEASED

                        Log.d("ROV", "backward0");
                        backward.setTextColor(0xffffffff);


                        return true; // if you want to handle the touch event
                }
                return false;
            }
        });

        down.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        // PRESSED

                        Log.d("ROV", "down1");
                        down.setTextColor(0xffffc107);
                        vb.vibrate(300);


                        return true; // if you want to handle the touch event
                    case MotionEvent.ACTION_UP:
                        // RELEASED

                        Log.d("ROV", "down0");
                        down.setTextColor(0xffffffff);


                        return true; // if you want to handle the touch event
                }
                return false;
            }
        });


        down.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        // PRESSED

                        Log.d("ROV", "down1");
                        down.setTextColor(0xffffc107);

                        vb.vibrate(300);

                        return true; // if you want to handle the touch event
                    case MotionEvent.ACTION_UP:
                        // RELEASED

                        Log.d("ROV", "down0");
                        down.setTextColor(0xffffffff);


                        return true; // if you want to handle the touch event
                }
                return false;
            }
        });


        left.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        // PRESSED

                        Log.d("ROV", "left1");
                        left.setTextColor(0xffffc107);

                        vb.vibrate(300);

                        return true; // if you want to handle the touch event
                    case MotionEvent.ACTION_UP:
                        // RELEASED

                        Log.d("ROV", "left0");
                        left.setTextColor(0xffffffff);


                        return true; // if you want to handle the touch event
                }
                return false;
            }
        });


        right.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        // PRESSED

                        vb.vibrate(300);

                        Log.d("ROV", "right1");
                        right.setTextColor(0xffffc107);

                        return true; // if you want to handle the touch event`
                    case MotionEvent.ACTION_UP:
                        // RELEASED


                        Log.d("ROV", "right0");
                        right.setTextColor(0xffffffff);


                        return true; // if you want to handle the touch event
                }
                return false;
            }
        });




        arml.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        // PRESSED

                        Log.d("ROV", "arml1");
                        arml.setTextColor(0xffffc107);

                        vb.vibrate(300);

                        return true; // if you want to handle the touch event
                    case MotionEvent.ACTION_UP:
                        // RELEASED
                        Log.d("ROV", "arml0");
                        arml.setTextColor(0xffffffff);


                        return true; // if you want to handle the touch event
                }
                return false;
            }
        });

        armr.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        // PRESSED

                        vb.vibrate(300);


                        Log.d("ROV", "armr1");
                        armr.setTextColor(0xffffc107);


                        return true; // if you want to handle the touch event
                    case MotionEvent.ACTION_UP:
                        // RELEASED

                        Log.d("ROV", "armr0");
                        armr.setTextColor(0xffffffff);


                        return true; // if you want to handle the touch event
                }
                return false;
            }
        });


    }


    public void define() {

        open = (Button) findViewById(R.id.open);
        close = (Button) findViewById(R.id.close);
        up = (Button) findViewById(R.id.up);
        down = (Button) findViewById(R.id.down);
        left = (Button) findViewById(R.id.left);
        right = (Button) findViewById(R.id.right);
        armr = (Button) findViewById(R.id.armr);
        arml = (Button) findViewById(R.id.arml);
        forward = (Button) findViewById(R.id.forward);
        backward = (Button) findViewById(R.id.backward);

    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {

        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;


    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {

            return true;

        }

        return super.onOptionsItemSelected(item);
    }


}
