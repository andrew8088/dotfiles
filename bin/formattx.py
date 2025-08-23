#!/usr/bin/env python3

import re
import sys
from datetime import datetime
import csv
from io import StringIO

def group_transactions_by_date(data):
    """
    Groups transaction lines by date, where each date starts a new transaction block.
    
    Args:
        data (str): Raw transaction data as a string
    
    Returns:
        list: List of lists, where each inner list contains all lines for one transaction
    """
    lines = data.strip().split('\n')
    grouped_transactions = []
    current_group = []
    
    # Regex to match date pattern: "MMM DD, YYYY"
    date_pattern = r'^[A-Z][a-z]{2} \d{1,2}, \d{4}'
    
    for line in lines:
        line = line.strip()
        
        # Skip empty lines
        if not line:
            continue
            
        # Check if this line starts with a date
        if re.match(date_pattern, line):
            # If we have a current group, save it before starting new one
            if current_group:
                grouped_transactions.append(current_group)
            
            # Start new group with this date line
            current_group = [line]
        else:
            # Add line to current group if we have one
            if current_group:
                current_group.append(line)
    
    # Don't forget the last group
    if current_group:
        grouped_transactions.append(current_group)
    
    return grouped_transactions

def parse_transaction_to_csv(transaction_lines):
    """
    Parse a single transaction group into CSV format: date,amount,description
    
    Args:
        transaction_lines (list): List of lines for one transaction
    
    Returns:
        tuple: (date, amount, description) or None if parsing fails
    """
    if not transaction_lines:
        return None
    
    # First line should be the date
    date_line = transaction_lines[0]
    date_match = re.match(r'^([A-Z][a-z]{2} \d{1,2}, \d{4})', date_line)
    if not date_match:
        return None
    
    # Convert date to YYYY-MM-DD format
    date_str = date_match.group(1)
    try:
        date_obj = datetime.strptime(date_str, '%b %d, %Y')
        formatted_date = date_obj.strftime('%Y-%m-%d')
    except ValueError:
        return None
    
    # Look for amount in any line (pattern: -$X,XXX.XX or $X,XXX.XX)
    amount = None
    amount_pattern = r'(-?\$[\d,]+\.\d{2})'
    
    for line in transaction_lines[1:]:  # Skip the date line
        amounts = re.findall(amount_pattern, line)
        if amounts:
            # Take the first amount, remove $ and commas
            raw_amount = amounts[0]
            amount = raw_amount.replace('$', '').replace(',', '')
            break;

    # Build description from non-date, non-amount-only lines
    description_parts = []
    for line in transaction_lines[1:]:
        line_clean = line.strip()
        if line_clean:
            # Remove amounts and extra whitespace, keep the descriptive text
            desc_line = re.sub(r'\s*-?\$[\d,]+\.\d{2}\s*', '', line_clean)
            desc_line = re.sub(r'\s+', ' ', desc_line).strip()
            if desc_line:
                description_parts.append(desc_line)
    
    # Join description and remove commas
    description = ' '.join(description_parts).replace(',', '')
    
    return (formatted_date, amount, description, 'CAD')

def transactions_to_csv(grouped_transactions):
    """
    Convert grouped transactions to CSV format
    
    Args:
        grouped_transactions (list): List of transaction groups
    
    Returns:
        str: CSV formatted string
    """
    output = StringIO()
    writer = csv.writer(output, quoting=csv.QUOTE_NONE)
    
    # Write header
    writer.writerow(['date', 'amount', 'name', 'currency'])
    
    # Process each transaction
    for transaction in grouped_transactions:
        parsed = parse_transaction_to_csv(transaction)
        if parsed:
            writer.writerow(parsed)
    
    return output.getvalue()

def print_grouped_transactions(grouped_transactions):
    """Pretty print the grouped transactions for debugging"""
    for i, group in enumerate(grouped_transactions):
        print(f"Transaction {i+1}:")
        for line in group:
            print(f"  {line}")
        print()

# Test with your sample data
sample_data = """
Jul 13, 2025 	
Online Transfer to Deposit Account
	-$8,000.00		$3,088.11	
Jul 10, 2025 	
Online Banking transfer - 1328
	-$9,329.01		$11,088.11	
Jul 8, 2025 	
Mortgage payment
	-$481.63		$20,417.12	
Jul 8, 2025 	
Mortgage payment
	-$500.83			
Jul 7, 2025 	
Utility Bill Pmt
Enbridge Gas
	-$33.43		$21,399.58
"""

if __name__ == "__main__":
    data = sys.stdin.read()
    transactions = group_transactions_by_date(data)
    csv_output = transactions_to_csv(transactions)
    print(csv_output)
