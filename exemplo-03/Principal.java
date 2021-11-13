class Principal {
    public static void main(String args[]){
        System.out.println("Olá , Docker!");
        int count = 1;
        while(true){
            try{
            Thread.sleep(5000);
            System.out.println("count: "+(++count));
            }catch(Exception e){
                e.printStackTrace();
            }
        }
    }
}