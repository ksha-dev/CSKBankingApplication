package com.adventnet.cskbank;

/** <p> Description of the table <code>Transaction</code>.
 *  Column Name and Table Name of  database table  <code>Transaction</code> is mapped
 * as constants in this util.</p> 
   * 
  * Primary Keys for this definition are  <br>
  <ul>
  * <li> {@link #TRANSACTION_ID}
  * <li> {@link #USER_ID}
  * <li> {@link #SENDER_ACCOUNT}
  * </ul>
 */
 
public final class TRANSACTION
{
    private TRANSACTION()
    {
    }
   
    /** Constant denoting the Table Name of this definition.
     */
    public static final String TABLE = "Transaction" ;
    /**
                            * This column is one of the Primary Key for this Table definition. <br>
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String TRANSACTION_ID= "TRANSACTION_ID" ;

    /*
    * The index position of the column TRANSACTION_ID in the table.
    */
    public static final int TRANSACTION_ID_IDX = 1 ;

    /**
                            * This column is one of the Primary Key for this Table definition. <br>
                            * Data Type of this field is <code>INTEGER</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String USER_ID= "USER_ID" ;

    /*
    * The index position of the column USER_ID in the table.
    */
    public static final int USER_ID_IDX = 2 ;

    /**
                            * This column is one of the Primary Key for this Table definition. <br>
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String SENDER_ACCOUNT= "SENDER_ACCOUNT" ;

    /*
    * The index position of the column SENDER_ACCOUNT in the table.
    */
    public static final int SENDER_ACCOUNT_IDX = 3 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is not nullable. <br>
                                */
    public static final String RECEIVER_ACCOUNT= "RECEIVER_ACCOUNT" ;

    /*
    * The index position of the column RECEIVER_ACCOUNT in the table.
    */
    public static final int RECEIVER_ACCOUNT_IDX = 4 ;

    /**
                            * Data Type of this field is <code>DECIMAL</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String AMOUNT= "AMOUNT" ;

    /*
    * The index position of the column AMOUNT in the table.
    */
    public static final int AMOUNT_IDX = 5 ;

    /**
                            * Data Type of this field is <code>DECIMAL</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String CLOSING_BALANCE= "CLOSING_BALANCE" ;

    /*
    * The index position of the column CLOSING_BALANCE in the table.
    */
    public static final int CLOSING_BALANCE_IDX = 6 ;

    /**
                            * Data Type of this field is <code>INTEGER</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String TYPE= "TYPE" ;

    /*
    * The index position of the column TYPE in the table.
    */
    public static final int TYPE_IDX = 7 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String TIME_STAMP= "TIME_STAMP" ;

    /*
    * The index position of the column TIME_STAMP in the table.
    */
    public static final int TIME_STAMP_IDX = 8 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>50</code>. <br>
                                   * This field is nullable. <br>
                                                     */
    public static final String REMARKS= "REMARKS" ;

    /*
    * The index position of the column REMARKS in the table.
    */
    public static final int REMARKS_IDX = 9 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String CREATED_AT= "CREATED_AT" ;

    /*
    * The index position of the column CREATED_AT in the table.
    */
    public static final int CREATED_AT_IDX = 10 ;

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
    public static final int MODIFIED_BY_IDX = 11 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is not nullable. <br>
                                */
    public static final String MODIFIED_AT= "MODIFIED_AT" ;

    /*
    * The index position of the column MODIFIED_AT in the table.
    */
    public static final int MODIFIED_AT_IDX = 12 ;

}
