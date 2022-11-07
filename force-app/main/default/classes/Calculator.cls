// Make a calculator and make count of its instances

public class Calculator {
    public static Integer count=0;
    public void getSum(Integer num1, Integer num2){
        System.debug('Addition  of ' + num1 + ' and ' + num2 + ' is : ' + (num1 + num2));
    }
    
    public void getSubtract(Integer num1, Integer num2){
        System.debug('Subraction of ' + num1 + ' and ' + num2 + ' is : ' + (num1-num2));  
    }
    
    public void getMultiply(Integer num1, Integer num2){
        System.debug('Multiplication of ' + num1 + ' and ' + num2 + ' is : ' + (num1 * num2));
    }
    
	public void getDivision(Decimal num1, Decimal num2){
        System.debug('Division of ' + num1 + ' and ' + num2 + ' is : ' + (num1 / num2).setScale(2));
    }    
    
    public Calculator(){
        count += 1;
    }
    
    public void getInstanceCount(){
        System.debug('Instance count : ' + count);
    }
    
}