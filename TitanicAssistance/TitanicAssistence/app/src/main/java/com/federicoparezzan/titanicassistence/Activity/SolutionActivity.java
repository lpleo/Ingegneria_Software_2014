package com.federicoparezzan.titanicassistence.Activity;

import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.federicoparezzan.titanicassistence.Memento.Originator;
import com.federicoparezzan.titanicassistence.R;
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
        getSupportActionBar().setTitle("Soluzione");

        TextView solution = (TextView) findViewById(R.id.solution);

        originator = Originator.getInstance();
        Node node = originator.getOriginatorState();

        solution.setText(node.getCode().getSoluzione());

        Button homeBT = (Button) findViewById(R.id.home);
        homeBT.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(SolutionActivity.this.getApplicationContext(), MainActivity.class);
                startActivity(intent);
            }
        });
    }

    //Faccio l'override del tasto back perchè voglio ripristinare lo stato: voglio quello del padre e non quello del figlio
    @Override
    public void onBackPressed() {

        super.onBackPressed();
        originator.restoreMemento();
    }
}
