import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;


public aspect Logger {
	File archivo = new File("src/log.txt");
    Date fecha = new Date();
    DateFormat formato = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy");
    
	
    pointcut created() : call(* createUser*(..) );
    after() : created() {
    	System.out.println("**** User created ****");
    }
    
    
    pointcut success() : call(* moneyMake*(..) );
    after() : success() {
    	if(!archivo.exists()) {
    		try {
    			archivo.createNewFile();
    		}catch(IOException ex) {
    			
    			
    		}
    		
    	}
    	else {
    		try(BufferedWriter bf = new BufferedWriter(new FileWriter("src/log.txt",true));) {
        		bf.write("Transaccion realizada:" + formato.format(fecha)+"\n");
        		
        	}
        	catch(Exception e) {
        		
        		
        	}
    	}
    	
    	System.out.println("**** Transaccion Guardada: "+ formato.format(fecha)+ " ****");
    }
    
    pointcut trans() : call(* *.moneyWithd*());
    after() : trans(){
    	if(!archivo.exists()) {
    		try {
    			archivo.createNewFile();
    		}catch(IOException ex) {
    			
    			
    		}
    		
    	}
    	else {
    		
    		try(BufferedWriter bf = new BufferedWriter(new FileWriter("src/log.txt",true));) {
        		bf.write("Retiro realizada:" + formato.format(fecha)+"\n");
        	}
        	catch(Exception e) {
        		
        		
        	}
    	}
    	
    	System.out.println("**** Retiro Guardado: "+ formato.format(fecha)+ " ****");
    	
    }
}
