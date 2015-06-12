package com.federicoparezzan.titanicassistence.Util;

import android.app.Application;
import android.content.Context;
import android.content.ContextWrapper;

import com.federicoparezzan.titanicassistence.Util.Utils;

import java.io.File;

/**
 * Created by carlo on 19/03/2015.
 */
public class MyAppSubclass extends Application {

    private String dbPath;
    private Context context;

    public String getDbPath() {
        if(dbPath==null){
            // Get DbPath
            ContextWrapper cw = new ContextWrapper(getApplicationContext());
            File dbFile = cw.getDatabasePath(Utils.DB_NAME);
            dbPath = dbFile.getAbsolutePath();
        }
        return dbPath;
    }

    public void setDbPath(String dbPath) {
        this.dbPath = dbPath;
    }
}
