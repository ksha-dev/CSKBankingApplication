package com.adventnet.cskbank;

/** <p> Description of the table <code>Account</code>.
 *  Column Name and Table Name of  database table  <code>Account</code> is mapped
 * as constants in this util.</p> 
   * 
  * Primary Key for this definition is  <br>
  <ul>
  * <li> {@link #ACCOUNT_NUMBER}
  * </ul>
 */
 
public final class ACCOUNT
{
    private ACCOUNT()
    {
    }
   
    /** Constant denoting the Table Name of this definition.
     */
    public static final String TABLE = "Account" ;
    /**
                            * This column is an Primary Key for this Table definition. <br>
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String ACCOUNT_NUMBER= "ACCOUNT_NUMBER" ;

    /*
    * The index position of the column ACCOUNT_NUMBER in the table.
    */
    public static final int ACCOUNT_NUMBER_IDX = 1 ;

    /**
                            * Data Type of this field is <code>INTEGER</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String USER_ID= "USER_ID" ;

    /*
    * The index position of the column USER_ID in the table.
    */
    public static final int USER_ID_IDX = 2 ;

    /**
                            * Data Type of this field is <code>INTEGER</code>. <br>
                            * Default Value is <code>1</code>. <br>
                     * This field is not nullable. If value for field is not set default value "<code>1</code>" , 
       * will be taken.<br>
                         */
    public static final String TYPE= "TYPE" ;

    /*
    * The index position of the column TYPE in the table.
    */
    public static final int TYPE_IDX = 3 ;

    /**
                            * Data Type of this field is <code>INTEGER</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String BRANCH_ID= "BRANCH_ID" ;

    /*
    * The index position of the column BRANCH_ID in the table.
    */
    public static final int BRANCH_ID_IDX = 4 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is not nullable. <br>
                                */
    public static final String LAST_TRANSACTED_AT= "LAST_TRANSACTED_AT" ;

    /*
    * The index position of the column LAST_TRANSACTED_AT in the table.
    */
    public static final int LAST_TRANSACTED_AT_IDX = 5 ;

    /**
                            * Data Type of this field is <code>CTEXT_CEK</code>. <br>
                     * Maximum length of this field value is <code>100</code>. <br>
                                   * This field is not nullable. <br>
                                */
    public static final String BALANCE= "BALANCE" ;

    /*
    * The index position of the column BALANCE in the table.
    */
    public static final int BALANCE_IDX = 6 ;

    /**
                            * Data Type of this field is <code>INTEGER</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String STATUS= "STATUS" ;

    /*
    * The index position of the column STATUS in the table.
    */
    public static final int STATUS_IDX = 7 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String CREATED_AT= "CREATED_AT" ;

    /*
    * The index position of the column CREATED_AT in the table.
    */
    public static final int CREATED_AT_IDX = 8 ;

    /**
                            * Data Type of this field is <code>INTEGER</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String MODIFIED_BY= "MODIFIED_BY" ;

    /*
    * The index position of the column MODIFIED_BY in the table.
    */
    public static final int MODIFIED_BY_IDX = 9 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is not nullable. <br>
                                */
    public static final String MODIFIED_AT= "MODIFIED_AT" ;

    /*
    * The index position of the column MODIFIED_AT in the table.
    */
    public static final int MODIFIED_AT_IDX = 10 ;

}
