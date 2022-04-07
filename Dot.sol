import "./deps/IERC20.sol";

pragma solidity ^0.8.10;

contract Dot is IERC20 {
    // 'State' variable definitions
    uint256 private _supply;

    // 'Storage' variable definitions
    mapping(address => uint256) private _balances;
    mapping(address => (address=> uint256)) private _allowances;

    // Initialization
    constructor (uint256 supply) {
        _supply = supply;
        _balances[msg.sender] = _supply;
    }

    // View contract/token name
    function name() external view returns (string memory) {
        return "Dot";
    }

    // Return total amount of tokens in supply
    function totalSupply() external view returns (uint256) {
        return _supply;
    }

    // Return token balance of a given holder
    function balanceOf(address holder) external view returns (uint256) {
        return _balances[holder];
    }

    // Transfers token ownership
    function transfer(address to, uint256 amount) external returns (bool) {
        require(_balances[msg.sender] >= amount, "Value to send exceeds caller balance.");
        require(to != address(0x0), "Cannot transfer to 0x0 address.")

        _balances[msg.sender] -= amount;
        _balances[to] += amount;

        emit Transfer(msg.sender, to, amount);

        return true;
    }

    // Approve another address to spend a given amount of callers tokens
    function approve(address spender, uint256 amount) external returns (bool) {
        require(_balances[msg.sender] >= amount, "Value to approve exceeds caller balance.");
        require(spender != address(0x0), "Cannot approve 0x0 address.");

        _allowances[msg.sender][spender] = 0;
        _allowances[msg.sender][spender] = amount;

        emit Approval(msg.sender, spender, amount);

        return true;
    }

    // Gets callers allowance for a given address
    function allowance(address owner, address spender) external view returns (uint256) {
        require(owner != address(0x0), "Owner cannot be 0x0 address.");
        require(spender != address(0x0), "Spender cannot be 0x0 address.");

        return _allowances[owner][spender];
    }

    // Transfers token ownership from third party using allowance
    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        require(_balances[from] >= amount, "Value to transfer exceeds owner balance.");
        require(_allowances[from][msg.sender] >= amount, "Value to transfer exceeds caller allowance.")
        require(to != address(0x0), "Cannot transfer to 0x0 address.");

        _allowances[from][msg.sender] -= amount;
        _balances[from] -= amount;
        _balances[to] += amount;

        emit Transfer(from, to, amount);

        return true;
    }

}
