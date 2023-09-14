# EVault Smart Contract

## Overview

The EVault Smart Contract is a decentralized application (DApp) that provides a secure and transparent way to mint, verify, and share important documents on the Ethereum blockchain. It leverages the Ethereum network's robustness and immutability to ensure document integrity and accessibility.

## Features

-   **Mint Documents**: Users can mint (create) new documents by specifying a unique content hash. Each document is represented as a non-fungible token (NFT), ensuring its uniqueness and ownership.

-   **Verify Documents**: Government officials, assigned the role of contract owner, can verify documents by marking them as "verified." This adds an additional layer of trust to the documents stored in the EVault.

-   **Share Documents**: Document owners can share their documents with other Ethereum addresses. This feature allows for controlled access to documents, ensuring privacy and security.

-   **Access Control**: The contract implements access control with roles for lawyers and judges, granting them specific privileges within the contract.

## Contract Roles

-   **Owner**: The contract creator is automatically assigned the role of "Owner." They have administrative privileges, including verifying documents and granting lawyer and judge roles.

-   **Lawyer**: Lawyers can be assigned the "Lawyer" role, allowing them to access certain contract functionalities, such as document verification.

-   **Judge**: Judges can be assigned the "Judge" role, allowing them access to specific contract features like document verification.

## Getting Started

1. **Deploy the Contract**: Deploy the EVault contract on the Ethereum network using Hardhat or any other Ethereum development framework.

2. **Mint Documents**: Users can mint documents by calling the `mintDocument` function, specifying the content hash of the document they want to mint.

3. **Verify Documents**: Government officials (contract owner) can verify documents using the `verifyDocument` function, marking them as verified.

4. **Share Documents**: Document owners can share their documents with other Ethereum addresses using the `shareDocument` function.

5. **Access Control**: The contract owner can grant the "Lawyer" and "Judge" roles to specific addresses using the `grantLawyerRole` and `grantJudgeRole` functions.

## Smart Contract Interactions

-   **Mint Documents**: Use the `mintDocument` function to mint a new document. Pass the content hash as an argument.

-   **Verify Documents**: The contract owner can use the `verifyDocument` function to verify documents.

-   **Share Documents**: Owners can share their documents with others by calling the `shareDocument` function and specifying the recipient's address.

-   **Check Document Details**: Use the `getDocumentDetails` function to retrieve document details, including ownership, content hash, and verification status.

-   **Role Management**: The contract owner can manage roles by granting the "Lawyer" and "Judge" roles to specific addresses.

## Additional Information

-   **Token Counter**: You can use the `tokencounter` function to check the current number of tokens (documents) minted in the contract.

-   **List All Documents**: The `getDocumentByIndex` function allows you to list all documents owned by a specific address.

## License

This project is licensed under the MIT License. See the [https://github.com/algorand/smart-contracts/blob/master/LICENSE](LICENSE) file for details.
