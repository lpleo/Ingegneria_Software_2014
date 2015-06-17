package com.federicoparezzan.titanicassistence.Activity;

import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.federicoparezzan.titanicassistence.R;
import com.federicoparezzan.titanicassistence.Tree.History;
import com.github.clans.fab.FloatingActionButton;

/**
 * Created by federicoparezzan on 14/06/15.
 */
public class ProblemNotSolved extends AppCompatActivity {

    public static final String TAG = "SolutionActivity";
    private Context context;
    private Resources res;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_problem_not_solved);

        context = getApplicationContext();
        res = getResources();

        Toolbar mToolbar = (Toolbar) findViewById(R.id.my_awesome_toolbar);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("  Problema irrisolto");
        getSupportActionBar().setIcon(R.mipmap.ic_launcher);


        final History history = History.getInstance();
        String code = history.createLastCodeWithUserId(context);

        TextView codeTV = (TextView) findViewById(R.id.code);
        codeTV.setText(code);


        FloatingActionButton callOffice = (FloatingActionButton) findViewById(R.id.menu_item_assistance);

        callOffice.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" + getString(R.string.phoneNumber)));
                startActivity(i);
            }
        });

        FloatingActionButton homeBT = (FloatingActionButton) findViewById(R.id.menu_item_home);
        homeBT.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                history.removeAllNode();
                Intent intent = new Intent(ProblemNotSolved.this.getApplicationContext(), MainActivity.class);
                startActivity(intent);
            }
        });

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
        if (id == R.id.logout) {
            SharedPreferences sharedPreferences = context.getSharedPreferences(getString(R.string.preference_file_key), Context.MODE_PRIVATE);
            sharedPreferences.edit().remove(getString(R.string.logged)).commit();

            Intent intent = new Intent(ProblemNotSolved.this.getApplicationContext(), LoginActivity.class);
            startActivity(intent);
            finish();

            return true;
        } else if (id == R.id.about) {

            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle(res.getString(R.string.aboutAlert));
            builder.setMessage(res.getString(R.string.messageAlert));
            try {
                AlertDialog alert = builder.create();
                alert.show();
            } catch (Exception e) {
                Log.e(this.getPackageName(),
                        "Exception raised on builder.create();");
            }

            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
