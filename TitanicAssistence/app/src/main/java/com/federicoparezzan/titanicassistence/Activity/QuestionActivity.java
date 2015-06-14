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
import android.widget.LinearLayout;
import com.federicoparezzan.titanicassistence.Memento.Originator;
import com.federicoparezzan.titanicassistence.Tree.History;
import com.federicoparezzan.titanicassistence.Tree.Node;
import com.federicoparezzan.titanicassistence.R;
import com.federicoparezzan.titanicassistence.Util.MyAppSubclass;

/**
 * Created by federicoparezzan on 29/05/15.
 */
public class QuestionActivity extends AppCompatActivity {

    public static final String TAG = "QuestionActivity";
    private Context context;
    private Resources res;

    private Node leaf;
    private Originator originator;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_question);

        context = getApplicationContext();
        res = getResources();

        Toolbar mToolbar = (Toolbar) findViewById(R.id.my_awesome_toolbar);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("  Problema");
        getSupportActionBar().setIcon(R.mipmap.ic_launcher);

        LinearLayout layoutQuestion = (LinearLayout) findViewById(R.id.layoutQuestion);
        Button solutionBT = (Button) findViewById(R.id.solution);
        Button callOfficeBT = (Button) findViewById(R.id.callOffice);

        originator = Originator.getInstance();
        leaf = originator.getOriginatorState();

        int cont = 0;

        //Creo la grafica a runtime poichè non so quanti potrebbero essere i problemi.
        for (Node c: leaf.getChildren()){

            final Button newQuestionBT = new Button(context);
            newQuestionBT.setId(cont); //identificativo univoco
            newQuestionBT.setText(c.getCode().getTipo_problema()); //setto il testo
            newQuestionBT.setTextAppearance(context, R.style.ButtonStyle); //setto lo stile in material design che ho creato
            newQuestionBT.setBackgroundResource(R.drawable.custom_btn2);  //setto il personalissimo background
            newQuestionBT.setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View v) {

                    //salvo lo stato con il Memento del bottone che ho cliccato. Il bottone lo identifico con l'id
                    originator = Originator.getInstance();
                    originator.setOriginatorState(leaf.getChildren().get(v.getId()));
                    originator.createMemento();

                    History history =History.getInstance();
                    history.addNode(leaf.getChildren().get(v.getId()));

                    //se ci sono figli ricreo l'activity
                    if (leaf.getChildren().get(v.getId()).getChildren().size() != 0) {

                        Intent intent = new Intent(QuestionActivity.this.getApplicationContext(), QuestionActivity.class);
                        startActivity(intent);

                    //altrimenti salvo lo stato del padre nel caso dovessi ripristinarlo nel momento in cui l'utente preme back
                    } else {
                        originator.createMemento(leaf);

                        Intent intent = new Intent(QuestionActivity.this.getApplicationContext(), SolutionActivity.class);
                        startActivity(intent);

                    }
                }
            });
            layoutQuestion.addView(newQuestionBT); //aggiungo il bottone al layout
            cont++;
        }

        //creo la schermata con la soluzione basandomi sullo stato salvato nel Memento
        solutionBT.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent intent = new Intent(QuestionActivity.this.getApplicationContext(), SolutionActivity.class);
                startActivity(intent);

            }
        });

        callOfficeBT.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent intent = new Intent(QuestionActivity.this.getApplicationContext(), ProblemNotSolved.class);
                startActivity(intent);

            }
        });


    }

    @Override
    public void onBackPressed() {

        super.onBackPressed();
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

            Intent intent = new Intent(QuestionActivity.this.getApplicationContext(), LoginActivity.class);
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
