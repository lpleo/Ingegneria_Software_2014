package com.federicoparezzan.titanicassistence.Activity;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.RelativeLayout;

import com.federicoparezzan.titanicassistence.Database.DBManager;
import com.federicoparezzan.titanicassistence.R;
import com.federicoparezzan.titanicassistence.Tree.Tree;
import com.federicoparezzan.titanicassistence.Util.Utils;

/**
 * Created by federicoparezzan on 26/05/15.
 */
public class SplashActivity extends Activity {

    private DBManager myDBManager;
    private Resources res;
    private Context context;

    private SharedPreferences sharedPref;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.splash_screen);

        res = getResources();
        context = getApplicationContext();

        //Inizializzo il database se non è presente
        inizializeDB();

        //Creo una struttura dati ad albero in cui ogni nodo è un problema.
        //Ogni nodo può avere dei figli.
        Tree tree = Tree.getInstance(getApplicationContext());

        RelativeLayout relativeLayout = (RelativeLayout) findViewById(R.id.layout_click);
        relativeLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                //Recupero dalle SharedPreferences un token. Se isLogged è false significa che l'utente
                //è la prima volta che si logga oppure ha fatto un logout.
                sharedPref = getSharedPreferences(getString(R.string.preference_file_key), Context.MODE_PRIVATE);
                boolean isLogged = sharedPref.getBoolean(getString((R.string.logged)), false);

                //Se è logggato viene caricato la MainActivity
                if (isLogged){
                    Intent intent = new Intent(SplashActivity.this.getApplicationContext(), MainActivity.class);
                    startActivity(intent);
                    finish();

                //altrimenti viene caricata la LoginActivity
                } else {
                    Intent intent = new Intent(SplashActivity.this.getApplicationContext(), LoginActivity.class);
                    startActivity(intent);
                    finish();
                }
            }
        });
    }



    //Metodo che crea e inizializza il database
    protected void inizializeDB() {
        /**
         * Initialize DB
         */
        try {
            int myVersion = 0;
            SQLiteDatabase db = null;
            myVersion = this.getPackageManager().getPackageInfo(this.getPackageName(), 0).versionCode;
            myDBManager = new DBManager(context, Utils.DB_NAME, myVersion);

            db = myDBManager.getReadableDatabase();
            db.close();
        } catch (PackageManager.NameNotFoundException nnfe) {
            Log.e(this.getPackageName(),
                    "NameNotFoundException raised opening db: " + nnfe);
        } catch (Error e) {
            Log.e(this.getPackageName(), "Error raised opening db: " + e);
            alertDBError();
            return;
        }
    }

    //Metodo che segnala un errore se l'inizializzazione del db non va a buon fine
    private void alertDBError() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(res.getString(R.string.splashDBErrorMessage));
        builder.setMessage(res.getString(R.string.splashDBErrorMessage));
        builder.setCancelable(false);
        builder.setPositiveButton(res.getString(R.string.splashDBErrorClose),
                new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        SplashActivity.this.finish();
                    }
                });
        try {
            AlertDialog alert = builder.create();
            alert.show();
        } catch (Exception e) {
            Log.e(this.getPackageName(),
                    "Exception raised on builder.create();");
        }
    }
}
