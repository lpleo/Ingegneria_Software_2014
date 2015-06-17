package com.federicoparezzan.titanicassistence.Activity;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.federicoparezzan.titanicassistence.Bean.CredentialBean;
import com.federicoparezzan.titanicassistence.Persistence.CredentialPersistence;
import com.federicoparezzan.titanicassistence.R;
import com.federicoparezzan.titanicassistence.Util.MyAppSubclass;
import com.federicoparezzan.titanicassistence.Util.Utils;

/**
 * Created by federicoparezzan on 27/05/15.
 */
public class LoginActivity  extends AppCompatActivity {

    public static final String TAG = "LoginActivity";

    private Context context;
    private Resources res;
    private MyAppSubclass myAppSubclass;


    private EditText usernameET;
    private EditText passwordET;
    private Button loginBT;

    private SharedPreferences sharedPref;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        context = getApplicationContext();
        res = getResources();
        myAppSubclass = (MyAppSubclass) context.getApplicationContext();

        //Setto la Toolbar
        Toolbar mToolbar = (Toolbar) findViewById(R.id.my_awesome_toolbar);
        setSupportActionBar(mToolbar);
        getSupportActionBar().setTitle("  Login");
        getSupportActionBar().setIcon(R.mipmap.ic_launcher);

        usernameET = (EditText) findViewById(R.id.usernameET);
        passwordET = (EditText) findViewById(R.id.passwordET);
        loginBT = (Button) findViewById(R.id.loginBT);

        sharedPref = context.getSharedPreferences(getString(R.string.preference_file_key), Context.MODE_PRIVATE);

        loginBT.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                //Se le credenziali sono corrette carico la MainActivity
                if (checkCorrectCredential()) {
                    Intent intent = new Intent(LoginActivity.this.getApplicationContext(), MainActivity.class);
                    startActivity(intent);
                    finish();
                }

            }
        });


    }

    /*Metodo che verifica la correttezza delle credenziali.
      Controlla:
      1) username e password non devono essere di lunghezza nulla
      2) Tramite una query verifico se username e password sono presenti del database dell'app. Se loadOne lancia un'eccezione
         è perchè no username è sbagliato
     */
    private boolean checkCorrectCredential(){
        if (usernameET.getText().length() == 0 || passwordET.getText().length() == 0){
            CharSequence text = "Inserisci le credenziali";
            Toast toast = Toast.makeText(context, text, Toast.LENGTH_SHORT);
            toast.show();

            return false;
        }
        try {
            CredentialBean credentialBean = CredentialPersistence.loadOne(myAppSubclass.getDbPath(), String.valueOf(usernameET.getText()));
            if (credentialBean.getPassword().equals(String.valueOf(passwordET.getText()))){

                sharedPref = getSharedPreferences(getString(R.string.preference_file_key), Context.MODE_PRIVATE);
                SharedPreferences.Editor editor = sharedPref.edit();
                editor.putBoolean(getString(R.string.logged), true);
                editor.putString(getString(R.string.username),usernameET.getText().toString() );
                editor.commit();

                return true;
            }
        } catch (Exception e){
            CharSequence text = "Credenziali errate";
            Toast toast = Toast.makeText(context, text, Toast.LENGTH_SHORT);
            toast.show();

            if (Utils.USE_DEBUG) {
                Log.e(TAG, "checkCorrectCredential(): exception raised on incorrect credential " + e);
            }
            return false;
        }
        CharSequence text = "Credenziali errate";
        Toast toast = Toast.makeText(context, text, Toast.LENGTH_SHORT);
        toast.show();
        return false;
    }




}
