Public class Main{
    public static void main(String[] args) {
        HashMap<String, String> movies = new HashMap<>();
        movies.put("index1", "row1");
        movies.put("index2", "row2");
        movies.put("index3", "row3");

        System.out.println(movies.get("index3"));
    }
}