//Decs
StringDict morsedict;

String filepath;
String[] wordlist;
boolean consider_letter_spaces;
StringDict palindromes;
IntDict longest_morse_palindromes;
int longest_listsize;
StringList normal_palindromes;

//Funcs
String morsify(String word) {
  String morseCode = "";
  word = word.toLowerCase();
  for (char c : word.toCharArray()) {
    morseCode += morsedict.get(str(c)) + " ";
  }
  return trim(morseCode);
}

//Main
void setup() {
  size(10, 10);

  //Inits
  morsedict = new StringDict();
  morsedict.set("a", "•–");
  morsedict.set("b", "–•••");
  morsedict.set("c", "–•–•");
  morsedict.set("d", "–••");
  morsedict.set("e", "•");
  morsedict.set("f", "••–•");
  morsedict.set("g", "––•");
  morsedict.set("h", "••••");
  morsedict.set("i", "••");
  morsedict.set("j", "•–––");
  morsedict.set("k", "–•–");
  morsedict.set("l", "•–••");
  morsedict.set("m", "––");
  morsedict.set("n", "–•");
  morsedict.set("o", "–––");
  morsedict.set("p", "•––•");
  morsedict.set("q", "––•–");
  morsedict.set("r", "•–•");
  morsedict.set("s", "•••");
  morsedict.set("t", "–");
  morsedict.set("u", "••–");
  morsedict.set("v", "•••–");
  morsedict.set("w", "•––");
  morsedict.set("x", "–••–");
  morsedict.set("y", "–•––");
  morsedict.set("z", "––••");
  morsedict.set("1", "•––––");
  morsedict.set("2", "••–––");
  morsedict.set("3", "•••––");
  morsedict.set("4", "••••–");
  morsedict.set("5", "•••••");
  morsedict.set("6", "–••••");
  morsedict.set("7", "––•••");
  morsedict.set("8", "–––••");
  morsedict.set("9", "––––•");
  morsedict.set("0", "–––––");
  morsedict.set(".", "•–•–•–");
  morsedict.set(" ", "      ");
  morsedict.set("&", "•–•••");
  morsedict.set("-", "–••••–");
  morsedict.set(",", "––••––");
  morsedict.set("\'", "•––––•");
  morsedict.set("/", "–••–•");
  morsedict.set("!", "–•–•––");
  morsedict.set("@", "•––•–•");

  ////Palindromes
  println("Accessed palindromes module.");
  //Generate list of morse palindromes
  filepath = "E:\\Programming\\English_words.txt";
  consider_letter_spaces = false;
  if (consider_letter_spaces) {
    println("Note: Currently considering morse WITH spaces between letter codes.\n");
  } else {
    println("Note: Currently considering morse WITHOUT spaces between letter codes\n");
  }
  
  wordlist = loadStrings(filepath);
  palindromes = new StringDict();

  for (String word : trim(wordlist)) {
    String morse = morsify(word);
    if (!consider_letter_spaces)
      morse = join(split(morsify(word), ' '), "");
    if (morse.equals(new String(reverse(morse.toCharArray()))))
      palindromes.set(word, morse);
  }
  palindromes.sortKeys();
  println("Found " + palindromes.size() + " morse palindromes in " + filepath + ".\n");

  //Save main list to .txt
  PrintWriter writer = createWriter("morsepalindromes_en.txt");
  for (String dictkey : palindromes.keys()) {
    writer.println(dictkey + " = " + palindromes.get(dictkey));
  }
  writer.flush();
  writer.close();
  println("Saved morse palindromes to 'morsepalindromes_en.txt'.\n");

  //Generate list of normal palindromes that are also morse palindromes
  normal_palindromes = new StringList();
  for (String dictkey : palindromes.keys()) {
    if (dictkey.toLowerCase().equals(new String(reverse(dictkey.toLowerCase().toCharArray()))))
      normal_palindromes.append(dictkey);
  }
  println("Normal palindromes that are also morse palindromes: ");
  int i = 0;
  for (String normal : normal_palindromes) {
    i++;
    println("N°" + i + ": " + normal + ", which in morse is " + palindromes.get(normal) + " with a dot-dash length of " + join(split(palindromes.get(normal), ' '), "").length() + ".");
  }
  println("");

  //Generate list of longest palindromes
  longest_morse_palindromes = new IntDict();
  longest_listsize = 25;
  for (String dictkey : palindromes.keys()) {
    if (longest_morse_palindromes.size() < longest_listsize) {
      longest_morse_palindromes.set(dictkey, join(split(palindromes.get(dictkey), ' '), "").length());
      longest_morse_palindromes.sortValuesReverse();
    } else if (longest_morse_palindromes.valueArray()[longest_morse_palindromes.size()-1] < palindromes.get(dictkey).length()) {
      longest_morse_palindromes.remove(longest_morse_palindromes.keyArray()[longest_morse_palindromes.size()-1]);
      longest_morse_palindromes.set(dictkey, join(split(palindromes.get(dictkey), ' '), "").length());
      longest_morse_palindromes.sortValuesReverse();
    }
  }
  println("Longest morse palindromes: ");
  i = 0;
  for (String longkey : longest_morse_palindromes.keys()) {
    i++;
    println("N°" + i + ": " + longkey + ", which in morse is " + palindromes.get(longkey) + " with a dot-dash length of " + longest_morse_palindromes.get(longkey) + ".");
  }
  println("");
}
void draw() {
  exit();
}
