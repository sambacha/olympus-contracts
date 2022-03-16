# `mecha_OLYMPUS`

> TLDR: Middleware buffer for surcharge fee pricing of token dumps

## EVO Protocol

> [https://hackmd.io/@manifold/mecha-olympus](https://hackmd.io/@manifold/mecha-olympus)

EVO deposit tokens are minted and burned on-demand by deposit and withdraw operations directly on the contract. All three operations such as deposit, withdraw and transfer can equally contribute to the transfer rates that are tracked totally and individually (as per holder) by the smart contract for some defined time period.

The underlying token price is determined dynamically (and individually for each holder) based on the information stored or updated in the smart contract during previous transactions

$$
P_{t+1}(h, a):=\sqrt{\frac{D_{t}}{S_{t}}}+I_{t+1}^{\prime}(h, a)
$$

The above equation will compute the price for a holder \textif{h} to purchase
certain amount a of EVO tokens in exchange for a base deposit in the underlying instrument
(ETH) at the given discrete time-point \textif{t + 1} (or equivalently a transaction
number), where \textif{Dt} stands for the deposit of ETH in the smart contract
at previous time-point and \textif{St} stands for the total supply of EVO tokens so
far

\textif{Dt} stands for deposits at a point in time
\label{total.supply.so-far}
\(S\_{t}\) = Total Supply So Far

\begin{equation}
I\_{t+1}^{\prime}(h, a)
\end{equation}

discounted interest and it can grow proportionally to a within
a range of [0,0.24] of \(a\)

\label{discounted.interest.range}
\begin{equation}
[0,0.24] \text { of } a
\end{equation}

How much an individual account has transferred over the last 25 days

\label{total.individual.avg.transfer.rate}
\begin{equation}
\operatorname{avg}\left(R*{t+1}(h, a)\right):=\operatorname{avg}\left(R*{t}(h)\right)+a
\end{equation}

The Total Daily Average Transfer Rate for all holders
\label{total.aggregate.daily.avg.transfer.rate}
\begin{equation}
\operatorname{avg}\left(\bar{R}_{t+1}(h, a)\right):=\operatorname{avg}\left(\bar{R}_{t}(h)\right)+a
\end{equation}

Future Transfer Ratio

\begin{equation}
\tau=\frac{\operatorname{avg}\left(R*{t+1}(h, a)\right)}{\operatorname{avg}\left(\bar{R}*{t+1}(h, a)\right)}
\end{equation}

Ownership Ratio By an Account in a previous point of time
\begin{equation}
\theta=\frac{B*{t}(h)}{S*{t}}
\end{equation}

\label{Interest Rate}
\begin{equation}
I\_{t+1}(h, a):=\frac{a \times \min (\operatorname{avg}(\beta, \tau), m)}{100}
\end{equation}

\label{Discounted Interest Rate}
\begin{equation}
I*{t+1}^{\prime}(h, a):=\max \left(I*{t+1}(h, a), l*{t+1}^{\prime}(h, a)\right)-l*{t+1}^{\prime}(h, a)
\end{equation}

\label{Normalized Interest Rate }
\begin{equation}
l\_{t+1}^{\prime}(h, a):=\frac{a \times \sqrt{l \* \max \left(\min \left(\theta, l^{2}\right), 1\right)}}{100}
\end{equation}
