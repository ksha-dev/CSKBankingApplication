package com.adventnet.cskbank;

/** <p> Description of the table <code>AuditLog</code>.
 *  Column Name and Table Name of  database table  <code>AuditLog</code> is mapped
 * as constants in this util.</p> 
   * 
  * Primary Key for this definition is  <br>
  <ul>
  * <li> {@link #AUDIT_ID}
  * </ul>
 */
 
public final class AUDITLOG
{
    private AUDITLOG()
    {
    }
   
    /** Constant denoting the Table Name of this definition.
     */
    public static final String TABLE = "AuditLog" ;
    /**
                            * This column is an Primary Key for this Table definition. <br>
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String AUDIT_ID= "AUDIT_ID" ;

    /*
    * The index position of the column AUDIT_ID in the table.
    */
    public static final int AUDIT_ID_IDX = 1 ;

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
                                          * This field is nullable. <br>
                                */
    public static final String TARGET_ID= "TARGET_ID" ;

    /*
    * The index position of the column TARGET_ID in the table.
    */
    public static final int TARGET_ID_IDX = 3 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>20</code>. <br>
                                   * This field is nullable. <br>
                                */
    public static final String OPERATION= "OPERATION" ;

    /*
    * The index position of the column OPERATION in the table.
    */
    public static final int OPERATION_IDX = 4 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>20</code>. <br>
                                   * This field is nullable. <br>
                                */
    public static final String STATUS= "STATUS" ;

    /*
    * The index position of the column STATUS in the table.
    */
    public static final int STATUS_IDX = 5 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>255</code>. <br>
                                   * This field is nullable. <br>
                                */
    public static final String DESCRIPTION= "DESCRIPTION" ;

    /*
    * The index position of the column DESCRIPTION in the table.
    */
    public static final int DESCRIPTION_IDX = 6 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String MODIFIED_AT= "MODIFIED_AT" ;

    /*
    * The index position of the column MODIFIED_AT in the table.
    */
    public static final int MODIFIED_AT_IDX = 7 ;

}
