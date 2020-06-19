
import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.bank.Bank;

public aspect Logger {
	
	private static final Path logFile = Paths.get("Log.txt");
	
	pointcut success() : call(* Bank.createUser(..) );
    pointcut moneyTransaction() : call(* Bank.moneyMake*(..) );
    pointcut moneyWithdrawal() : call(* Bank.moneyWith*(..) );

    after() : success() {
    
    	saveLog("User created");
    
    }

    after() : moneyTransaction() {
    	
    	saveLog("Realizar transaccion");
    	
    }
    
    after() : moneyWithdrawal() {
    	
    	saveLog("Retirar dinero");
    	
    }
    
    private void saveLog(String transactionType) {
    	
    	String date;
    	
    	try( BufferedWriter bw = Files.newBufferedWriter( 
    		Files.exists(logFile) ? logFile : Files.createFile(logFile), 
    		StandardOpenOption.APPEND) ) {
    		
    		date = (new SimpleDateFormat("HH:mm:ss dd/MM/yyyy")).format(new Date());
    		bw.append( String.format("%s %s\n", 
    			transactionType.replace(" ", "_"), date) );

    		System.out.println( String.format(
    			"**** %s: %s ****", transactionType, date) );
    		
    	} catch (IOException e) {
    		e.printStackTrace(); }
    	
    }

}
