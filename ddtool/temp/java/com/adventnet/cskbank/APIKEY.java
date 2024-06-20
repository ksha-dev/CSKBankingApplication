package com.adventnet.cskbank;

/** <p> Description of the table <code>APIKey</code>.
 *  Column Name and Table Name of  database table  <code>APIKey</code> is mapped
 * as constants in this util.</p> 
   * 
  * Primary Key for this definition is  <br>
  <ul>
  * <li> {@link #AK_ID}
  * </ul>
 */
 
public final class APIKEY
{
    private APIKEY()
    {
    }
   
    /** Constant denoting the Table Name of this definition.
     */
    public static final String TABLE = "APIKey" ;
    /**
                            * This column is an Primary Key for this Table definition. <br>
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String AK_ID= "AK_ID" ;

    /*
    * The index position of the column AK_ID in the table.
    */
    public static final int AK_ID_IDX = 1 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>20</code>. <br>
                                   * This field is nullable. <br>
                                                     */
    public static final String ORG_NAME= "ORG_NAME" ;

    /*
    * The index position of the column ORG_NAME in the table.
    */
    public static final int ORG_NAME_IDX = 2 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>40</code>. <br>
                                   * This field is nullable. <br>
                                                     */
    public static final String API_KEY= "API_KEY" ;

    /*
    * The index position of the column API_KEY in the table.
    */
    public static final int API_KEY_IDX = 3 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String CREATED_AT= "CREATED_AT" ;

    /*
    * The index position of the column CREATED_AT in the table.
    */
    public static final int CREATED_AT_IDX = 4 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String VALID_UNTIL= "VALID_UNTIL" ;

    /*
    * The index position of the column VALID_UNTIL in the table.
    */
    public static final int VALID_UNTIL_IDX = 5 ;

    /**
                            * Data Type of this field is <code>BOOLEAN</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String IS_ACTIVE= "IS_ACTIVE" ;

    /*
    * The index position of the column IS_ACTIVE in the table.
    */
    public static final int IS_ACTIVE_IDX = 6 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is not nullable. <br>
                                */
    public static final String MODIFIED_AT= "MODIFIED_AT" ;

    /*
    * The index position of the column MODIFIED_AT in the table.
    */
    public static final int MODIFIED_AT_IDX = 7 ;

}
