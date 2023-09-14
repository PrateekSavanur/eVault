// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import OpenZeppelin libraries for access control and ERC721
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract eVault is Ownable, ERC721URIStorage, AccessControl {
    // Define roles for lawyers and judges
    bytes32 public constant LAWYER_ROLE = keccak256("LAWYER_ROLE");
    bytes32 public constant JUDGE_ROLE = keccak256("JUDGE_ROLE");

    struct Access {
        address user;
        bool access;
    }

    // Document structure
    struct Document {
        address owner;
        string contentHash;
        bool verified;
    }

    mapping(address => uint256[]) private index;

    // Counter to keep track of the number of tokens minted
    uint256 private tokenCounter = 0;

    // Mapping from token ID to Document
    mapping(address => mapping(uint256 => Document)) private documents;
    mapping(string => bool) private minted;
    mapping(address => Access) private share;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
        // Assign owner role to the contract creator
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    // Override supportsInterface to resolve conflict
    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721URIStorage, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    // Function to mint a new document
    function mintDocument(string memory _contentHash) external {
        require(!minted[_contentHash], "Already minted");
        tokenCounter++;
        _mint(msg.sender, tokenCounter);
        share[msg.sender].access = true;
        share[msg.sender].user = msg.sender;
        index[msg.sender].push(tokenCounter);
        documents[msg.sender][tokenCounter] = Document(msg.sender, _contentHash, false);
        minted[_contentHash] = true;
    }

    // Function to verify a document by a government official
    function verifyDocument(address _address, uint256 _tokenId) external onlyOwner {
        require(_exists(_tokenId), "Token does not exist");
        documents[_address][_tokenId].verified = true;
    }

    // Function to share a document with another address
    function shareDocument(address _recipient, uint256 _tokenId) external {
        require(ownerOf(_tokenId) == msg.sender, "Only owner can grant permission");
        share[_recipient].user = _recipient;
        share[_recipient].access = true;
    }

    // Function to grant lawyer and judge roles
    function grantLawyerRole(address _account) external onlyOwner {
        grantRole(LAWYER_ROLE, _account);
    }

    function grantJudgeRole(address _account) external onlyOwner {
        grantRole(JUDGE_ROLE, _account);
    }

    // Function to check if a user has lawyer or judge role
    function hasLawyerRole(address _account) public view returns (bool) {
        return hasRole(LAWYER_ROLE, _account);
    }

    function hasJudgeRole(address _account) public view returns (bool) {
        return hasRole(JUDGE_ROLE, _account);
    }

    // Function to get document details
    function getDocumentDetails(
        address _address,
        uint256 _tokenId
    ) public view returns (address, string memory, bool) {
        require(_exists(_tokenId), "Token does not exist");
        require(share[msg.sender].access, "Invalid Access");
        Document memory doc = documents[_address][_tokenId];
        return (doc.owner, doc.contentHash, doc.verified);
    }

    function tokencounter() external view returns (uint256) {
        return tokenCounter;
    }

    function getDocumentByIndex(address _address) public view {
        uint256 count = balanceOf(_address);
        for (uint i = 0; i < count; i++) {
            getDocumentDetails(_address, index[_address][i]);
        }
    }
}
