class IndianMoneySeperator {
  static String formatAmount(String amountStr) {
    // String amountStr = amount.toString();
    int len = amountStr.length;
    String formattedAmount = '';

    for (int i = 0; i < len; i++) {
      formattedAmount += amountStr[i];

      int posFromRight = len - i - 1;

      if (posFromRight % 2 == 1 && posFromRight != 1) {
        formattedAmount += ',';
      }
    }

    return formattedAmount;
  }
}
