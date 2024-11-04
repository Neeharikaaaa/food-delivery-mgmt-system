/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package food;
import javax.swing.*;
import java.sql.*;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.*;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Ambica7400
 */
public class Payment extends javax.swing.JFrame {

    /**
     * Creates new form Payment
     */
    Connection con;
    Statement st;
    PreparedStatement ps;
    ResultSet rs;
    String p="";
    int restaurant,branch,customer;
    public Payment(int msg1, int msg2, int msg3) {
        restaurant = msg1;
        branch = msg2;
        customer = msg3;
        initComponents();
        try
        {
            Class.forName("oracle.jdbc.OracleDriver");
            //JOptionPane.showMessageDialog(this,"Driver Loaded!");
            try {
            con = DriverManager.getConnection("jdbc:oracle:thin:@DESKTOP-E58UQJS:1521:orcl",
                    "hr","A174");
            //JOptionPane.showMessageDialog(this,"Connected to Oracle database!");
            }
            catch (SQLException ex) {
            Logger.getLogger(Payment.class.getName()).log(Level.SEVERE,null, ex);
            JOptionPane.showMessageDialog(this,ex.getMessage());
            }
        }
        catch(ClassNotFoundException ex)
        {
            Logger.getLogger(Payment.class.getName()).log(Level.SEVERE,null, ex);
            JOptionPane.showMessageDialog(this,ex.getMessage());
        }
        
        double a=0;
        String sql4 = "select sum(total) as num from bill";
        try {
                ps = con.prepareStatement(sql4);
                st = con.createStatement();
                rs = ps.executeQuery(sql4);
                if (rs.next()) {
                    a = rs.getInt("num"); 
                }
                // Add code to handle the ResultSet here
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(null, "Error executing SQL query: " + e.getMessage());
                e.printStackTrace();
            }
        amt.setText(String.valueOf(a));
        cid.setText(String.valueOf(customer));
        
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jComboBox1 = new javax.swing.JComboBox<>();
        cid = new javax.swing.JTextField();
        amt = new javax.swing.JTextField();
        jLabel4 = new javax.swing.JLabel();
        paymode = new javax.swing.JTextField();
        jLabel5 = new javax.swing.JLabel();
        jToggleButton1 = new javax.swing.JToggleButton();
        exit = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jLabel1.setText("Customer ID");

        jLabel3.setText("Amount");

        jComboBox1.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Netbanking", "Google Pay", "Card", "Cash" }));
        jComboBox1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jComboBox1ActionPerformed(evt);
            }
        });

        jLabel4.setText("Payment Mode");

        paymode.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                paymodeActionPerformed(evt);
            }
        });

        jLabel5.setText("PAYMENT");

        jToggleButton1.setText("Click to Pay");
        jToggleButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jToggleButton1ActionPerformed(evt);
            }
        });

        exit.setText("Exit");
        exit.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                exitActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(37, 37, 37)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jLabel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jLabel3, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(0, 0, Short.MAX_VALUE)
                        .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 84, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                        .addComponent(amt, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(0, 0, Short.MAX_VALUE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(cid, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 54, Short.MAX_VALUE)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(paymode)
                                .addGap(7, 7, 7))
                            .addComponent(jComboBox1, javax.swing.GroupLayout.PREFERRED_SIZE, 123, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addGap(25, 25, 25))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(jLabel5, javax.swing.GroupLayout.PREFERRED_SIZE, 65, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(150, 150, 150))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(jToggleButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 111, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(exit, javax.swing.GroupLayout.PREFERRED_SIZE, 75, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(40, 40, 40))))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(22, 22, 22)
                .addComponent(jLabel5, javax.swing.GroupLayout.PREFERRED_SIZE, 29, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(32, 32, 32)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(jComboBox1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(cid, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel3)
                    .addComponent(amt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(9, 9, 9)
                .addComponent(jLabel4)
                .addGap(5, 5, 5)
                .addComponent(paymode, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 50, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jToggleButton1)
                    .addComponent(exit))
                .addGap(31, 31, 31))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jComboBox1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jComboBox1ActionPerformed
        // TODO add your handling code here:
        int pm = jComboBox1.getSelectedIndex();
        String m;
        switch (pm)
        {
            case 0:
                m = "Netbanking";
                p = "paid";
                break;
            case 1:
                m = "Google Pay";
                p = "paid";
                break;
            case 2:
                m = "Card";
                p = "unpaid";
                break;
            case 3:
                m = "Cash";
                p = "unpaid";
                break;
            default:
                m = "";
                p = "";
        }
        paymode.setText(m);
    }//GEN-LAST:event_jComboBox1ActionPerformed

    private void paymodeActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_paymodeActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_paymodeActionPerformed

    private void jToggleButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jToggleButton1ActionPerformed
        // TODO add your handling code here:
        int oid=0;
        try
        {
            int pid=0; 
            java.sql.Date d1 = new java.sql.Date (System.currentTimeMillis());
             
            try {
                String sql2 = "SELECT count(payid) AS num FROM payment";
                ps = con.prepareStatement(sql2);
                st = con.createStatement();
                rs = ps.executeQuery(sql2);
                if (rs.next()) {
                    pid = rs.getInt("num"); 
                }

            } 
            catch (SQLException e) {
                JOptionPane.showMessageDialog(null, "Error executing SQL query: " + e.getMessage());
                e.printStackTrace();
            }

            // Insert payment details into the payment table
            String sql = "INSERT INTO payment (payid, paytype, status, amt) VALUES (?, ?, ?, ?)";
            try{
                ps = con.prepareStatement(sql);
                ps.setInt(1, pid + 1); 
                ps.setString(2, paymode.getText()); 
                ps.setString(3, p);
                ps.setDouble(4, Double.parseDouble(amt.getText())); 

                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    JOptionPane.showMessageDialog(null, "Payment completed successfully.");
                } else {
                    JOptionPane.showMessageDialog(null, "Failed to insert payment.");
                    return;
                }
            }
            catch (SQLException e) {
                JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
                e.printStackTrace();
                return;
            }
            
            String sql3 = "SELECT count(oid) AS num FROM orders";
            try
            {
                ps = con.prepareStatement(sql3);
                st = con.createStatement();
                rs = ps.executeQuery(sql3);
                if (rs.next()) {
                    oid = rs.getInt("num"); // Assigning value to pid
                }
                ps.close ();
                rs.close ();
            }
            catch (SQLException e)
            {
                JOptionPane.showMessageDialog(null, "Error executing SQL query: " + e.getMessage());
                e.printStackTrace();
            }
            
            String sql5 = "insert into orders (oid,cid,dpid,rid,bid,odate,ddate,rating,review,pid) values (?,?,?,?,?,?,?,?,?,?)";
            
            try
            {
                ps = con.prepareStatement(sql5);
                ps.setInt(1,oid+1); 
                ps.setInt(2,customer);//cid); 
                ps.setInt(3,1);//dpid
                ps.setInt(4,restaurant);//rid);
                ps.setInt(5,branch);//bid);
                ps.setDate(6,d1);
                ps.setDate(7,d1);
                ps.setInt(8,5);
                ps.setString(9,"");
                ps.setInt(10,pid);
                ps.executeUpdate();
                JOptionPane.showMessageDialog(null, "Order placed successfully.");
                ps.close(); rs.close(); 
            }
            catch (SQLException e)
            {
                JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
                e.printStackTrace();
            }            
            rs.close();
            ps.close();
        }
        catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
            e.printStackTrace();
        }
        
        String callProcedure = "{CALL InsertOrderDetails(?, ?, ?)}";
        try {
            CallableStatement cstmt1 = con.prepareCall(callProcedure);
            cstmt1.setInt(1,restaurant);
            cstmt1.setInt(2,branch);
            cstmt1.setInt(3,oid+1);
            cstmt1.execute();
            cstmt1.close();
            JOptionPane.showMessageDialog(null, "Inserted into order_details");
        } catch (SQLException e) {
            Logger.getLogger(Food.class.getName()).log(Level.SEVERE, null, e);
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
            e.printStackTrace();
        }
    }//GEN-LAST:event_jToggleButton1ActionPerformed

    private void exitActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_exitActionPerformed
        // TODO add your handling code here:
        clearBill();
        System.exit(0);
    }//GEN-LAST:event_exitActionPerformed

    private void clearBill ()
    {
        String sql7 = "delete from bill";
        try  {
            ps = con.prepareStatement(sql7);
            int rowsAffected = ps.executeUpdate();
            JOptionPane.showMessageDialog(null, "Deleted " + rowsAffected + " rows from bill.");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error executing SQL query: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * @param args the command line arguments
     */
    public void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Payment.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Payment.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Payment.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Payment.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Payment(restaurant,branch,customer).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTextField amt;
    private javax.swing.JTextField cid;
    private javax.swing.JButton exit;
    private javax.swing.JComboBox<String> jComboBox1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JToggleButton jToggleButton1;
    private javax.swing.JTextField paymode;
    // End of variables declaration//GEN-END:variables
}
