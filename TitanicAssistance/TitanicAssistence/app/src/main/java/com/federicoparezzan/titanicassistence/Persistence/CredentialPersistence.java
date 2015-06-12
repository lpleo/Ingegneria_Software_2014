package com.federicoparezzan.titanicassistence.Persistence;

import android.content.ContentValues;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;

import com.federicoparezzan.titanicassistence.Bean.CredentialBean;

import java.text.ParseException;
import java.util.ArrayList;




/**
 * Created by federicoparezzan on 11/03/15.
 */
public class CredentialPersistence {

    private static String TAG = "CredentialPersistence";
    public static String TABLE_NAME = "credenziali";
    public static String[] ROW = { "id_utente_cred", "password"};

    public CredentialPersistence(){}


    public static int save(String dbPath, CredentialBean credentialBean) {
        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null,SQLiteDatabase.OPEN_READWRITE);
        int objId = -1;

        db.beginTransaction();
        try {
            ContentValues objValues = new ContentValues();
            objValues = setObjContentValues(objValues, credentialBean);

            long resultInsert = 0L;
            if ((resultInsert = db.insert(TABLE_NAME, null, objValues)) < 0) {
                throw new Exception("CredentialPersistence.save() exception raised on db");
            }
            // getting max vaule from _id
            String maxIdQuery = "SELECT max(_id) FROM " + TABLE_NAME;
            Cursor cursor = db.rawQuery(maxIdQuery, null);
            if (cursor.moveToFirst()) {
                objId = cursor.getInt(0);
            }
            cursor.close();

            db.setTransactionSuccessful();
        } catch (Exception e) {
            db.endTransaction();
            Log.e(TAG, "save(): exception raised on cursor " + e);
        } finally {
            db.endTransaction();
            db.close();
        }

        return objId;
    }

    public static void saveAll(String dbPath, ArrayList<CredentialBean> credentialBeanArrayList)
            throws Exception {
        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null,
                SQLiteDatabase.OPEN_READWRITE);

        db.beginTransaction();
        try {
            for (CredentialBean credentialBean : credentialBeanArrayList) {
                ContentValues objValues = new ContentValues();
                objValues = setObjContentValues(objValues, credentialBean);

                long resultInsert = 0L;
                if ((resultInsert = db.insert(TABLE_NAME, null, objValues)) < 0) {
                    throw new Exception("ETF.saveTemp() exception raised on db");
                }
            }

            db.setTransactionSuccessful();
        } catch (Exception e) {
            db.endTransaction();
            Log.e("ETF", "saveTemp(): exception raised on cursor " + e);
            throw new Exception("ETF.saveTemp() exception raised on db");
        } finally {
            db.endTransaction();
            db.close();
        }
    }




    private static ContentValues setObjContentValues(ContentValues objValues, CredentialBean credentialBean) {

        objValues.put(CredentialBean.ID_UTENTE_CRED, credentialBean.getId_utente_cred());
        objValues.put(CredentialBean.PASSWORD, credentialBean.getPassword());


        return objValues;
    }

    public static CredentialBean loadOne(String dbPath, String username) {
        CredentialBean credentialBean = null;
        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null,
                SQLiteDatabase.OPEN_READWRITE);

        db.beginTransaction();
        try {
            Cursor cursor = db.query(TABLE_NAME, ROW, CredentialBean.ID_UTENTE_CRED + "=" + username, null,null, null, null);

            if (cursor.moveToFirst()) {
                credentialBean = new CredentialBean();
                try {
                    credentialBean = setObj(credentialBean, cursor);
                } catch (Exception e) {
                    Log.e(TAG," Exception raised while loading object: " + e);
                }
            }
            cursor.close();
            db.setTransactionSuccessful();
        } catch (Exception e) {
            db.endTransaction();
            Log.e(TAG, "loadOne(): exception raised on cursor " + e);
        } finally {
            db.endTransaction();
            db.close();
        }
        return credentialBean;
    }

    public static ArrayList<CredentialBean> loadAll(String dbPath) throws SQLException {

        ArrayList<CredentialBean> list = new ArrayList<CredentialBean>();
        CredentialBean element = null;
        String queryString = "SELECT * FROM " + TABLE_NAME;

        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null,
                SQLiteDatabase.OPEN_READWRITE);

        db.beginTransaction();
        try {
            Cursor cursor = db.rawQuery(queryString, null);
            while (cursor.moveToNext()) {
                element = new CredentialBean();
                element = setObj(element, cursor);
                list.add(element);
            }
            cursor.close();
            db.setTransactionSuccessful();
        } catch (Exception e) {
            db.endTransaction();
            Log.e(TAG, "loadAll(): exception raised on cursor " + e);
        } finally {
            db.endTransaction();
            db.close();
        }
        return list;
    }

    private static CredentialBean setObj(CredentialBean element, Cursor cursor) throws ParseException {

        element.setId_utente_cred(String.valueOf(cursor.getInt(0)));
        element.setPassword(cursor.getString(1));

        return element;
    }

    public static void DeleteAll(String dbPath) {
        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null,
                SQLiteDatabase.OPEN_READWRITE);

        db.beginTransaction();
        try {
            db.delete(TABLE_NAME, null, null);
            db.setTransactionSuccessful();
        } catch (Exception e) {
            db.endTransaction();
            Log.e(TAG, "dbPath(): exception raised on cursor " + e);
        } finally {
            db.endTransaction();
            db.close();
        }
    }

    public static void delete(String dbPath, int username) {
        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null, SQLiteDatabase.OPEN_READWRITE);

        db.beginTransaction();
        try {
            db.delete(TABLE_NAME, CredentialBean.ID_UTENTE_CRED + "=" + username, null);
            db.setTransactionSuccessful();
        } catch (Exception e) {
            db.endTransaction();
            Log.e(TAG, "delete(): exception raised on cursor " + e);
        } finally {
            db.endTransaction();
            db.close();
        }
    }

    public void updateSingleValue(String dbPath, String key, String value, CredentialBean credentialBean) {
        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null, SQLiteDatabase.OPEN_READWRITE);

        db.beginTransaction();
        try {
            ContentValues upValues = new ContentValues();

            upValues.put(key, value);

            db.update(TABLE_NAME, upValues, CredentialBean.ID_UTENTE_CRED + "=" + credentialBean.getId_utente_cred(), null);
            db.setTransactionSuccessful();
        } catch (Exception e) {
            db.endTransaction();
            Log.e(TAG, "updateSingleValue(): exception raised on cursor " + e);
        } finally {
            db.endTransaction();
            db.close();
        }
    }

    public void update(String dbPath, CredentialBean credentialBean){
        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null, SQLiteDatabase.OPEN_READWRITE );

        db.beginTransaction();
        try {
            ContentValues objValues = new ContentValues();
            objValues = setObjContentValues(objValues, credentialBean);
            db.update(TABLE_NAME, objValues, CredentialBean.ID_UTENTE_CRED + "=" + credentialBean.getId_utente_cred(), null );
            db.setTransactionSuccessful();
        }catch (Exception e){
            db.endTransaction();
            Log.e(TAG,"update(): exception raised on cursor "+e);
        }finally {
            db.endTransaction();
            db.close();
        }
    }

}
