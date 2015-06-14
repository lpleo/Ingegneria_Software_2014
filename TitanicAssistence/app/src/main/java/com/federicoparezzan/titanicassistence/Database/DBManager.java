package com.federicoparezzan.titanicassistence.Database;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import android.content.Context;
import android.content.res.AssetManager;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class DBManager extends SQLiteOpenHelper {

    private static String TAG = "DBManager";

	private String dbName = null;
	private int dbVersion = 0;
	private final Context myContext;
	SQLiteDatabase db = null;

	public DBManager(Context __context, String __dbName, int __dbVersion) {
		super(__context, __dbName, null, __dbVersion);
		this.myContext = __context;
		this.dbName = __dbName;
		this.dbVersion = __dbVersion;
	}

	@Override
	public void onCreate(SQLiteDatabase __db) {
		this.db = __db;
		try {
			createDataBase(__db);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new Error("Error copying database");
		}
	}

	private void createDataBase(SQLiteDatabase __db) throws Exception {
		/**
		 * Open SQL file number XX.sql
		 */
		InputStream myInput = myContext.getAssets().open("sql/" + 1 + ".sql");
		BufferedReader reader = new BufferedReader(new InputStreamReader(
				myInput));

		__db.beginTransaction();
		try {
			String oneRow = "";
			StringBuilder builder = new StringBuilder();
			while ((oneRow = reader.readLine()) != null) {
				// Log.i("SQL_INSTRUCTION: ",oneRow);
				__db.execSQL(oneRow);
			}
			__db.setTransactionSuccessful();
		} catch (IOException ioe) {
			Log.e(myContext.getPackageName(),
					"createDataBase(): database name: " + __db.toString() + " "
							+ ioe);
			throw ioe;
		} catch (SQLException sqle) {
			// TODO: handle exception
			Log.e(myContext.getPackageName(),
					"createDataBase(): database name: " + __db.toString() + " "
							+ sqle);
			throw sqle;
		} finally {
			// Close the streams
			reader.close();
			myInput.close();
			__db.endTransaction();
		}
	}

	@Override
	public void onUpgrade(SQLiteDatabase __db, int oldVersion, int newVersion) {
		// Log.i(myContext.getPackageName(),"onUpgrade(): database name: "+__db.toString()+" old_v="+oldVersion+" new_v="+newVersion);
		try {
			upgradeFromDDL(__db, myContext.getAssets(), oldVersion, newVersion);
		} catch (IOException ioe) {
			Log.e(myContext.getPackageName(), "onUpgrade(): old_v="
					+ oldVersion + " new_v=" + newVersion
					+ " raised IOException: " + ioe.toString());
			throw new SQLException(ioe.getMessage());
		} catch (SQLException sqle) {
			throw sqle;
		}
	}

	private void upgradeFromDDL(SQLiteDatabase db,
			AssetManager myContextAssetsManager, int oldVersion, int newVersion)
			throws IOException {

		for (int curVersion = oldVersion + 1; curVersion <= newVersion; curVersion++) {

			/**
			 * Open SQL file number XX.sql
			 */
			InputStream myInput = null;
			try {
				myInput = myContextAssetsManager.open("sql/" + curVersion
						+ ".sql");
			} catch (IOException ioe) {
				Log.e("DBMAnager", "File sql don't exists " + ioe);
				throw ioe;
			}
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					myInput));

			db.beginTransaction();
			try {
				String oneRow = "";
				StringBuilder builder = new StringBuilder();
				while ((oneRow = reader.readLine()) != null) {
					// if start with comment do not execute
					if (!oneRow.startsWith("--")) {
						db.execSQL(oneRow);
					}
				}
				db.setTransactionSuccessful();
			} catch (IOException ioe) {
				Log.e(myContext.getPackageName(),
						"updgradeFromDDL(): database name: " + db.toString()
								+ " " + ioe);
				throw ioe;
			} catch (SQLException sqle) {
				// TODO: handle exception
				Log.e(myContext.getPackageName(),
						"updgradeFromDDL(): database name: " + db.toString()
								+ " " + sqle);
				throw sqle;
			} finally {
				// Close the streams
				reader.close();
				myInput.close();
				db.endTransaction();
			}
		}
	}

	@SuppressWarnings("unused")
	private void BufferedReader() {
		// TODO Auto-generated method stub

	}

	@Override
	public synchronized void close() {
		// TODO Auto-generated method stub
		// this.db = null;
		if (db != null) {
			this.db.close();
		}
		this.db = null;
		super.close();
	}

	public SQLiteDatabase getReadableDB() {
		return this.getReadableDatabase();
	}

	public SQLiteDatabase getWritableDB() {
		return this.getWritableDatabase();
	}
}
