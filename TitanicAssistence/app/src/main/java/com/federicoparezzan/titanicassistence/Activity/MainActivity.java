package com.federicoparezzan.titanicassistence.Activity;


import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import com.federicoparezzan.titanicassistence.Memento.Originator;
import com.federicoparezzan.titanicassistence.R;
import com.federicoparezzan.titanicassistence.Tree.History;
import com.federicoparezzan.titanicassistence.Tree.Node;
import com.federicoparezzan.titanicassistence.Tree.Tree;
import com.github.clans.fab.FloatingActionButton;


public class MainActivity extends AppCompatActivity {

    public static final String TAG = "MainActivity";
    private Context context;
    private Resources res;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        context = getApplicationContext();
        res = getResources();

        Toolbar mToolbar = (Toolbar) findViewById(R.id.my_awesome_toolbar);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("  Home");
        getSupportActionBar().setIcon(R.mipmap.ic_launcher);

        Button buttonCharter = (Button) findViewById(R.id.buttonCharter);
        Button buttonDiporto = (Button) findViewById(R.id.buttonDiporto);
        FloatingActionButton callOffice = (FloatingActionButton) findViewById(R.id.callOffice);

        callOffice.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent i = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" + getString(R.string.phoneNumber)));
                startActivity(i);
            }
        });

        buttonCharter.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {



                //Ottengo il nodo radice
                Tree tree = Tree.getInstance(getApplicationContext());
                Node root = tree.getRoot();

                History history =History.getInstance();
                history.addNode(root.getChildren().get(0));

                //Creo un Memento in cui salvo lo stato del nodo in modo da ricordarmi a che nodo sono arrivato
                Originator originator = Originator.getInstance();
                originator.setOriginatorState(root.getChildren().get(0)); //01 = charter
                originator.createMemento();

                Intent intent = new Intent(MainActivity.this.getApplicationContext(), QuestionActivity.class);
                startActivity(intent);
            }
        });

        buttonDiporto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                //Ottengo il nodo radice
                Tree tree = Tree.getInstance(getApplicationContext());
                Node root = tree.getRoot();

                History history = History.getInstance();
                history.addNode(root.getChildren().get(1));

                //Creo un Memento in cui salvo lo stato del nodo in modo da ricordarmi a che nodo sono arrivato
                Originator originator = Originator.getInstance();
                originator.setOriginatorState(root.getChildren().get(1)); //02 = diporto
                originator.createMemento();

                Intent intent = new Intent(MainActivity.this.getApplicationContext(), QuestionActivity.class);
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

            Intent intent = new Intent(MainActivity.this.getApplicationContext(), LoginActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
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
