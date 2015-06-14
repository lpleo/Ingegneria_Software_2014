package com.federicoparezzan.titanicassistence.Persistence;

import android.content.ContentValues;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;

import com.federicoparezzan.titanicassistence.Bean.ProblemBean;

import java.text.ParseException;
import java.util.ArrayList;


/**
 * Created by federicoparezzan on 11/03/15.
 */
public class ProblemPersistence {

    private static String TAG = "ProblemPersistence";
    public static String TABLE_NAME = "problemi";
    public static String[] ROW = { "id_problema", "tipo_problema", "soluzione", "tipo_barca", "tipologia"};


    public ProblemPersistence(){}


    public static int save(String dbPath, ProblemBean problemBean) {
        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null,SQLiteDatabase.OPEN_READWRITE);
        int objId = -1;

        db.beginTransaction();
        try {
            ContentValues objValues = new ContentValues();
            objValues = setObjContentValues(objValues, problemBean);

            long resultInsert = 0L;
            if ((resultInsert = db.insert(TABLE_NAME, null, objValues)) < 0) {
                throw new Exception("problemPersistence.save() exception raised on db");
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

    public static void saveAll(String dbPath, ArrayList<ProblemBean> problemBeanArrayList)
            throws Exception {
        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null,
                SQLiteDatabase.OPEN_READWRITE);

        db.beginTransaction();
        try {
            for (ProblemBean problemBean : problemBeanArrayList) {
                ContentValues objValues = new ContentValues();
                objValues = setObjContentValues(objValues, problemBean);

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




    private static ContentValues setObjContentValues(ContentValues objValues, ProblemBean problemBean) {

        objValues.put(ProblemBean.ID_PROBLEMA, problemBean.getId_problema());
        objValues.put(ProblemBean.TIPO_PROBLEMA, problemBean.getTipo_problema());
        objValues.put(ProblemBean.SOLUZIONE, problemBean.getSoluzione());
        objValues.put(ProblemBean.TIPO_BARCA, problemBean.getTipo_barca());
        objValues.put(ProblemBean.TIPOLOGIA, problemBean.getTipologia());

        return objValues;
    }

    public static ProblemBean loadOne(String dbPath, int id_problema) {
        ProblemBean problemBean = null;
        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null,
                SQLiteDatabase.OPEN_READWRITE);

        db.beginTransaction();
        try {
            Cursor cursor = db.query(TABLE_NAME, ROW, ProblemBean.ID_PROBLEMA + "=" + id_problema, null,null, null, null);

            if (cursor.moveToFirst()) {
                problemBean = new ProblemBean();
                try {
                    problemBean = setObj(problemBean, cursor);
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
        return problemBean;
    }

    public static ArrayList<ProblemBean> loadAll(String dbPath) throws SQLException {

        ArrayList<ProblemBean> list = new ArrayList<ProblemBean>();
        ProblemBean element = null;
        String queryString = "SELECT * FROM " + TABLE_NAME;

        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null,
                SQLiteDatabase.OPEN_READWRITE);

        db.beginTransaction();
        try {
            Cursor cursor = db.rawQuery(queryString, null);
            while (cursor.moveToNext()) {
                element = new ProblemBean();
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

    private static ProblemBean setObj(ProblemBean element, Cursor cursor) throws ParseException {

        element.setId_problema(cursor.getInt(0));
        element.setTipo_problema(cursor.getString(1));
        element.setSoluzione(cursor.getString(2));
        element.setTipo_barca(cursor.getString(3));
        element.setTipologia(cursor.getString(4));

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

    public static void delete(String dbPath, int id_problema) {
        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null, SQLiteDatabase.OPEN_READWRITE);

        db.beginTransaction();
        try {
            db.delete(TABLE_NAME, ProblemBean.ID_PROBLEMA + "=" + id_problema, null);
            db.setTransactionSuccessful();
        } catch (Exception e) {
            db.endTransaction();
            Log.e(TAG, "delete(): exception raised on cursor " + e);
        } finally {
            db.endTransaction();
            db.close();
        }
    }

    public void updateSingleValue(String dbPath, String key, String value, ProblemBean problemBean) {
        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null, SQLiteDatabase.OPEN_READWRITE);

        db.beginTransaction();
        try {
            ContentValues upValues = new ContentValues();

            upValues.put(key, value);

            db.update(TABLE_NAME, upValues, ProblemBean.ID_PROBLEMA + "=" + problemBean.getId_problema(), null);
            db.setTransactionSuccessful();
        } catch (Exception e) {
            db.endTransaction();
            Log.e(TAG, "updateSingleValue(): exception raised on cursor " + e);
        } finally {
            db.endTransaction();
            db.close();
        }
    }

    public void update(String dbPath, ProblemBean problemBean){
        SQLiteDatabase db = null;
        db = SQLiteDatabase.openDatabase(dbPath, null, SQLiteDatabase.OPEN_READWRITE );

        db.beginTransaction();
        try {
            ContentValues objValues = new ContentValues();
            objValues = setObjContentValues(objValues, problemBean);
            db.update(TABLE_NAME, objValues, ProblemBean.ID_PROBLEMA + "=" + problemBean.getId_problema(), null );
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
