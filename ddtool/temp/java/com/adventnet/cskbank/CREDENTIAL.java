package com.adventnet.cskbank;

/** <p> Description of the table <code>Credential</code>.
 *  Column Name and Table Name of  database table  <code>Credential</code> is mapped
 * as constants in this util.</p> 
   * 
  * Primary Key for this definition is  <br>
  <ul>
  * <li> {@link #USER_ID}
  * </ul>
 */
 
public final class CREDENTIAL
{
    private CREDENTIAL()
    {
    }
   
    /** Constant denoting the Table Name of this definition.
     */
    public static final String TABLE = "Credential" ;
    /**
                            * This column is an Primary Key for this Table definition. <br>
                            * Data Type of this field is <code>INTEGER</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String USER_ID= "USER_ID" ;

    /*
    * The index position of the column USER_ID in the table.
    */
    public static final int USER_ID_IDX = 1 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>255</code>. <br>
                                   * This field is nullable. <br>
                                */
    public static final String PASSWORD= "PASSWORD" ;

    /*
    * The index position of the column PASSWORD in the table.
    */
    public static final int PASSWORD_IDX = 2 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>255</code>. <br>
                                   * This field is nullable. <br>
                                */
    public static final String PIN= "PIN" ;

    /*
    * The index position of the column PIN in the table.
    */
    public static final int PIN_IDX = 3 ;

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
                            * Data Type of this field is <code>INTEGER</code>. <br>
                            * Default Value is <code>1</code>. <br>
                     * This field is not nullable. If value for field is not set default value "<code>1</code>" , 
       * will be taken.<br>
                         */
    public static final String MODIFIED_BY= "MODIFIED_BY" ;

    /*
    * The index position of the column MODIFIED_BY in the table.
    */
    public static final int MODIFIED_BY_IDX = 5 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is not nullable. <br>
                                */
    public static final String MODIFIED_AT= "MODIFIED_AT" ;

    /*
    * The index position of the column MODIFIED_AT in the table.
    */
    public static final int MODIFIED_AT_IDX = 6 ;

}
