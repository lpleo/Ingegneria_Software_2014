package com.federicoparezzan.titanicassistence.Activity;

import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.federicoparezzan.titanicassistence.Memento.Originator;
import com.federicoparezzan.titanicassistence.R;
import com.federicoparezzan.titanicassistence.Tree.History;
import com.federicoparezzan.titanicassistence.Tree.Node;

/**
 * Created by federicoparezzan on 12/06/15.
 */
public class SolutionActivity extends AppCompatActivity {

    public static final String TAG = "SolutionActivity";
    private Context context;
    private Resources res;

    private Originator originator;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_solution);

        context = getApplicationContext();
        res = getResources();

        Toolbar mToolbar = (Toolbar) findViewById(R.id.my_awesome_toolbar);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("  Soluzione");
        getSupportActionBar().setIcon(R.mipmap.ic_launcher);

        TextView solution = (TextView) findViewById(R.id.solution);

        originator = Originator.getInstance();
        Node node = originator.getOriginatorState();

        solution.setText(node.getCode().getSoluzione());

        Button homeBT = (Button) findViewById(R.id.home);
        homeBT.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                History history =History.getInstance();
                history.removeAllNode();

                Intent intent = new Intent(SolutionActivity.this.getApplicationContext(), MainActivity.class);
                startActivity(intent);
            }
        });



        Button callOfficeBT = (Button) findViewById(R.id.callOffice);
        callOfficeBT.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent intent = new Intent(SolutionActivity.this.getApplicationContext(), ProblemNotSolved.class);
                startActivity(intent);

            }
        });
    }

    //Faccio l'override del tasto back perchè voglio ripristinare lo stato: voglio quello del padre e non quello del figlio
    @Override
    public void onBackPressed() {

        super.onBackPressed();
        originator.restoreMemento();

        History history =History.getInstance();
        history.removeNode();

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

            Intent intent = new Intent(SolutionActivity.this.getApplicationContext(), LoginActivity.class);
            startActivity(intent);

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
