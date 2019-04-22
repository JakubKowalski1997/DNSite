<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Supermasters Test</title>
    <script src="https://unpkg.com/react@16/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@16/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>

    <link rel="stylesheet" href="https://unpkg.com/react-table@latest/react-table.css"/>

    <!-- JS -->
    <script src="https://unpkg.com/react-table@latest/react-table.js"></script>
    <script src="https://unpkg.com/react-table@latest/react-table.min.js"></script>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">
</head>
<body>

    <div id = "root"></div>

    <script  type = "text/babel">

        var ReactTable = window.ReactTable.default;

        class Supermasters extends React.Component {

            render() {
                return (
                    <div>
                        <Table ref="supTable"/>
                        <Form onSubmit = {this.onFormSubmit}/>
                    </div>
                );
            }

            onFormSubmit = () => {
                this.refs.supTable.refreshSupermastersTable();
                console.log("Form submited");
            }

        }

        const API = "http://localhost:8001/supermasters/all";

        class Table extends React.Component {

            constructor(props) {
                super(props);

                this.state = {
                    data : [],
                    selected: {}
                };
            }

            componentDidMount() {
                this.refreshSupermastersTable();
            }

            deleteSupermaster = (ip, nameserver) => {
                self = this;
                let URI = 'http://localhost:8001/supermasters/delete/' + ip + '/' + nameserver;
                fetch(URI)
                .then(function(response) {
                    return response;
                }).then(function(data) {
                    self.refreshSupermastersTable();
                });
            }

            toggleRow(supermasterId) {
                console.log(this.state.selected);
                const newSelected = Object.assign( {}, this.state.selected);
                newSelected[supermasterId] = !this.state.selected[supermasterId];
                this.setState({
                    selected: newSelected,
                });
            }

            renderTable() {
                const columns = [
                {
                    Header : "Select",
                    id : "checkbox",
                    accessor: "",
                    Cell: ({original}) => {
                        return (
                            <input
                                type = "checkbox"
                                className="checkbox"
                                checked={this.state.selected[JSON.stringify(original)] === true}
                                onChange = { () => this.toggleRow(JSON.stringify(original)) }
                            />
                        );
                    },
                    sortable: false,
                    width: 45
                },
                {
                    Header : "IP",
                    accessor: 'supermasterId.ip',
                },
                {
                    Header : "Nameserver",
                    accessor: 'supermasterId.nameserver',
                },
                {
                    Header : "Account",
                    accessor: "account",
                },
                {
                    Header : "Delete",
                    accessor : "",
                    Cell : ({original}) => {
                        return (
                            <button onClick={ () => {this.deleteSupermaster(original.supermasterId.ip, original.supermasterId.nameserver)}}> Delete </button>
                        );
                    },
                    sortable: false
                }

                ];

                return (
                    <ReactTable
                        data={this.state.data}
                        columns={columns}
                        defaultSorted={ [ { id : "account", desc: true} ] }
                    />
                );
            }

            refreshSupermastersTable() {
                fetch(API)
                    .then(response => {
                        if (response.ok) {
                            return response;
                        }
                    throw Error(response.status);
                    })
                    .then(response => response.json())
                    .then(data => {
                        this.setState({data: data, selected: {}});
                    })
                .catch(error => console.log(error + " coś nie tak"));
            }

            render() {
                return this.renderTable();
            }
        }

        class Form extends React.Component {

            constructor(props) {
                super(props);

                this.state = {

                    supermasters : [

                        {
                            supermasterId : {
                                ip : '',
                                nameserver : ''
                            },
                            account: ''
                        }

                    ]
                };

                this.handleNewSupermasters = this.handleNewSupermasters.bind(this);
            }

            addSupermaster = (event) => {
                event.preventDefault();
                this.setState((previousState) => ( {
                    supermasters : [... previousState.supermasters,
                        {
                            supermasterId : {
                                ip : '',
                                nameserver : ''
                            },
                            account: ''
                        }
                    ],
                }));
            }

            handleChange = (e) => {
                let supermasters = [...this.state.supermasters];
                if (e.target.className == 'ip') {
                    var supermasterId = supermasters[e.target.dataset.id]['supermasterId'];
                    supermasterId.ip = e.target.value;
                }
                else if (e.target.className == 'nameserver') {
                    var supermasterId = supermasters[e.target.dataset.id]['supermasterId'];
                    supermasterId.nameserver = e.target.value;
                }
                else if (e.target.className == 'account') {
                    supermasters[e.target.dataset.id]['account'] = e.target.value;
                }
                this.setState({supermasters}, () => console.log(this.state.supermasters));
            }

            render() {
                let {supermasters} = this.state;
                return (
                    <form className="form-signin" style = {{width: '100%'}}>
                    <table className = "table" style = {{width: '100%'}} >
                    <tbody>
                    {
                        supermasters.map((value, idx) => {
                            let supermasterIpId = 'ip-${idx}',
                                supermasterNameserverId = 'age-${idx}',
                                supermasterAccountId = 'account-${idx}';
                            return (
                                <tr key={idx}>
                                    <td>
                                    <input
                                        type = "text"
                                        name = {supermasterIpId}
                                        data-id = {idx}
                                        id = {supermasterIpId}
                                        value={supermasters[idx].supermasterId.ip}
                                        className="ip"
                                        placeholder="IP [required]"
                                        onChange = {this.handleChange}
                                    /></td>
                                    <td>
                                    <input
                                        type = "text"
                                        name = {supermasterNameserverId}
                                        data-id = {idx}
                                        id = {supermasterNameserverId}
                                        value={supermasters[idx].supermasterId.nameserver}
                                        className="nameserver"
                                        placeholder="Nameserver [required]"
                                        onChange = {this.handleChange}
                                    /></td>
                                    <td>
                                    <input
                                        type = "text"
                                        name = {supermasterAccountId}
                                        data-id = {idx}
                                        id = {supermasterAccountId}
                                        value={supermasters[idx].account}
                                        className="account"
                                        placeholder="Account [required]"
                                        onChange = {this.handleChange}
                                    /></td>
                                </tr>
                            )
                        })
                    }
                    <tr>
                        <td>
                            <button className="btn btn-lg btn-primary btn-block" onClick = {this.addSupermaster}> Add new supermaster </button>
                        </td>
                        <td>
                            <button className="btn btn-lg btn-primary btn-block" onClick={(e) => this.handleNewSupermasters(e)}>Submit</button>
                        </td>
                        <td></td><td></td>
                    </tr>
                    </tbody>
                    </table>
                    </form>
                )
            }

            handleNewSupermasters(event) {
                event.preventDefault();
                fetch('http://localhost:8001/supermasters', {
                    method: 'post',
                    body: JSON.stringify(this.state.supermasters),
                    headers: {'Content-Type': 'application/json'}
                }).then((response) => {
                    return response;
                }).then((data) => {
                    console.log('Created supermaster', data);
                    this.setState({supermasters : [
                        {
                            supermasterId : {
                                ip : '',
                                nameserver : ''
                            },
                            account: ''
                        }
                    ]});
                    this.props.onSubmit();
                });
            }

        }
        ReactDOM.render(<Supermasters />, document.getElementById("root"));



    </script>
</body>
</html>